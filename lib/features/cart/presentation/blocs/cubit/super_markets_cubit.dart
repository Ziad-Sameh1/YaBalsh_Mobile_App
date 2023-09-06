import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yabalash_mobile_app/core/constants/constants.dart';
import 'package:yabalash_mobile_app/features/cart/domain/entities/store_price.dart';
import 'package:yabalash_mobile_app/features/cart/domain/entities/supermarket_card_model.dart';
import 'package:yabalash_mobile_app/features/home/domain/entities/location.dart';
import 'package:yabalash_mobile_app/features/product_details/domain/usecases/get_product_details_usecase.dart';

import '../../../../../core/depedencies.dart';
import '../../../../../core/services/app_settings_service.dart';
import '../../../../../core/services/order_service.dart';
import '../../../../../core/services/zone_service.dart';
import '../../../../../core/utils/enums/request_state.dart';
import '../../../../home/domain/entities/price_model.dart';
import '../../../../home/domain/entities/store.dart';
import '../../../domain/entities/cart_item.dart';
import '../../../domain/usecases/get_store_usecase.dart';
import 'cart_cubit.dart';

part 'super_markets_state.dart';

class SuperMarketsCubit extends Cubit<SuperMarketsState> {
  final GetStoreUseCase getStoreUseCase;
  final GetProductDetailsUseCase getProductDetailsUseCase;

  SuperMarketsCubit({
    required this.getProductDetailsUseCase,
    required this.getStoreUseCase,
  }) : super(const SuperMarketsState());

  void setSuperMarketIndex({required int index}) {
    getIt<OrderService>().setSelectedSuperMarket(
        supermarket: state.availableSupermarkets![index]);
    getIt<CartCubit>()
        .changeSupermarketSelected(state.availableSupermarkets![index]);
    emit(state.copyWith(selectedSupermarketIndex: index));
  }

  void _updateAvaialbleSupermarketsMap(
      PriceModel priceModel, Map<int, int> supermarketsIds) {
    final supermarketId = priceModel.storeId!;
    final currentCount = supermarketsIds[supermarketId] ??
        0; // if first time found count will be 0 otherwise will be current count
    supermarketsIds[supermarketId] = currentCount + 1;
  }

  List<int> _getAvailableSupermarketsIds(
      Map<int, int> supermarketsIds, List<CartItem> cart) {
    // get stores that are repeated in all cart products
    return supermarketsIds.entries
        .where((entry) => entry.value == cart.length)
        .map((entry) => entry.key)
        .toList();
  }

  Future<List<CartItem>> _getCartProductsDetails() async {
    final cartProducts = getIt<CartCubit>().cart;
    List<CartItem> products = List<CartItem>.empty(growable: true);

    for (CartItem element in cartProducts) {
      if (element.product!.prices!.length < 3) {
        final getProductDetailsResponse =
            await getProductDetailsUseCase(GetProductDetailsParams(
          withNearStores: true,
          productId: element.product!.id!,
        ));
        getProductDetailsResponse.fold(
          (failure) =>
              emit(state.copyWith(storeRequestState: RequestState.error)),
          (product) => products.add(element.copyWith(product: product)),
        );
      } else {
        products.add(element);
      }
    }

    getIt<CartCubit>().setCartItemsList(products);
    return products;
  }

  Future<Map<String, dynamic>> _getSupermarketsPrices() async {
    final cartProducts = await _getCartProductsDetails();
    Map<String, StorePrice> storesTotalPrices = {};
    Map<int, int> supermarketsIds = {};
    for (var cartProduct in cartProducts) {
      int quantity = cartProduct.quantity!;
      for (var priceModel in cartProduct.product!.prices!.entries) {
        double price = priceModel.value.price!;
        bool isAvailable = priceModel.value.isAvailable!;
        _updateAvaialbleSupermarketsMap(priceModel.value, supermarketsIds);

        if (storesTotalPrices.containsKey(priceModel.key)) {
          StorePrice storePrice = storesTotalPrices[priceModel.key]!;
          double totalPrice = (storePrice.price! + (quantity * price));
          storesTotalPrices.update(
            priceModel.key,
            (value) => storePrice.copyWith(
              price: totalPrice,
              isAvailable: value.isAvailable! && isAvailable,
            ),
          );
        } else {
          //first addition
          storesTotalPrices[priceModel.key] =
              StorePrice(price: (quantity * price), isAvailable: isAvailable);
        }
      }
    }

    final storeIds =
        _getAvailableSupermarketsIds(supermarketsIds, cartProducts);

    // sort stores prices
    Map<String, StorePrice> sortedStoresPrices =
        Map.fromEntries(storesTotalPrices.entries.toList()
          ..sort(
            (a, b) => a.value.price!.compareTo(b.value.price!),
          ));

    return {'storeIds': storeIds, 'storePrices': sortedStoresPrices};
  }

  void getSuperMarkets([bool? removeCart]) async {
    bool hasError = false;
    List<SuperMarketCardModel> supermarkets =
        List<SuperMarketCardModel>.empty(growable: true);

    final supermarketPrices = await _getSupermarketsPrices();

    List<int> storeIds = supermarketPrices['storeIds'];
    Map<String, StorePrice> storesPrices = supermarketPrices['storePrices'];

    for (int id in storeIds) {
      final response = await getStoreUseCase(GetStoreParams(id: id));
      response.fold((failure) {
        hasError = true;

        emit(state.copyWith(storeRequestState: RequestState.error));
        return;
      }, (store) {
        bool isStoreInZone = _checkStoreInSameZone(store);

        if (isStoreInZone) {
          final storePriceModel = storesPrices[store.name];
          if (storePriceModel != null) {
            supermarkets.add(SuperMarketCardModel(
                store: store,
                price: storePriceModel.price,
                saving:
                    (storesPrices.values.last.price! - storePriceModel.price!),
                isAvailable: storePriceModel.isAvailable));
          }
        }
      });
    }

    if (!hasError) {
      supermarkets.sort(
        (a, b) => a.price!.compareTo(b.price!),
      );

      if (removeCart != null) {
        getIt<CartCubit>().clearCart();
      }

      emit(state.copyWith(
          availableSupermarkets:
              supermarkets.where((element) => element.isAvailable!).toList(),
          storeRequestState: RequestState.loaded,
          unAvailableSupermarkets:
              supermarkets.where((element) => !element.isAvailable!).toList()));
    }
  }

  void getSupermarketsTable([bool? removeCart]) async {
    /**
     * GET LIST OF CHEAPEST SUPERMARKET FOR EACH PRODUCT
     * GENERATE MAP WITH THE PRICE OF EACH PRODUCT IN EACH SUPERMARKET
     * */
    bool hasError = false;
    final cartProducts = await _getCartProductsDetails();
    Set<Store> availableStores = {};
    Map<CartItem, Map<Store, double>> table = {};
    // Set<int> cheapestStores = {};
    Map<int, Map<int, double>> storeProducts = {};
    Map<int, CartItem> products = {};
    Map<int, Store> stores = {};

    for (var cartProduct in cartProducts) {
      products[cartProduct.product!.id!] = cartProduct;
      double minPrice = maxDouble;
      int? minStoreId;
      Store? minStore;
      int quantity = cartProduct.quantity!;
      for (var priceModel in cartProduct.product!.prices!.entries) {
        double price = priceModel.value.price!;
        bool isAvailable = priceModel.value.isAvailable!;
        if (isAvailable) {
          if (storeProducts.containsKey(priceModel.value.storeId!)) {
            var productPrice = storeProducts[priceModel.value.storeId!];
            productPrice![cartProduct.product!.id!] = price * quantity;
          } else {
            int key = cartProduct.product!.id!;
            double value = price * quantity;
            storeProducts[priceModel.value.storeId!] = {key: value};
          }
        }
        if (isAvailable && price < minPrice) {
          int id = priceModel.value.storeId!;
          final response = await getStoreUseCase(GetStoreParams(id: id));
          response.fold((failure) {
            hasError = true;
            emit(state.copyWith(storeRequestState: RequestState.error));
            return;
          }, (store) {
            if (getIt<AppSettingsService>().isNearStores) {
              bool isStoreInZone = _checkStoreInSameZone(store);
              if (isStoreInZone) {
                // stores[cheapestStores.elementAt(id)] = store;
                // availableStores.add(store);
                minStoreId = id;
                minPrice = price;
                minStore = store;
              }
            } else {
              minStoreId = id;
              minPrice = price;
              minStore = store;
            }
          });
        }
      }
      // cheapestStores.add(minStoreId!);
      if (minStore != null) {
        stores[minStoreId!] = minStore!;
        availableStores.add(minStore!);
      }
    }



    for (var product in cartProducts) {
      for (var store in availableStores) {
        bool isExists = _checkIteminStoreId(store, product);
        if (table.containsKey(product)) {
          var currStores = table[product];
          if (isExists) {
            currStores![store] =
                product.product!.prices![store.name]!.price!;
          }
          else {
            currStores![store] = -1;
          }
          table[product] = currStores;
        } else {
          if (isExists) {
            table[product] = {
              store:
                  product.product!.prices![store.name]!.price!
            };
          } else {
            table[product] = {store: -1};
          }
        }
      }
    }

    if (!hasError) {
      if (removeCart != null) {
        getIt<CartCubit>().resetCart();
      }

      emit(state.copyWith(
          supermarketsTable: table,
          storeRequestState: RequestState.loaded,
          storeProducts: storeProducts,
          tableHeaderRow: availableStores.toList()));
    }
  }

  bool _checkIteminStoreId(Store store, CartItem product) {
    for (var s in product.product!.prices!.entries) {
      if (s.value.storeId == store.id) return true;
    }
    return false;
  }

  bool _checkStoreInSameZone(Store store) {
    final zoneId = getIt<ZoneService>().currentSubZone!.id;
    bool isInSameZone = false;

    if (store.locations!.isNotEmpty) {
      for (Location location in store.locations!) {
        if (location.subZoneId == zoneId) {
          isInSameZone = true;
          break;
        }
      }
    }
    return isInSameZone;
  }
}
