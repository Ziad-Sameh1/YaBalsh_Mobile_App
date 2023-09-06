import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yabalash_mobile_app/core/usecases/use_cases.dart';
import 'package:yabalash_mobile_app/core/utils/enums/request_state.dart';
import 'package:yabalash_mobile_app/features/cart/presentation/blocs/cubit/cart_cubit.dart';
import 'package:yabalash_mobile_app/features/flyers/domain/usecases/get_flyers_usecase.dart';
import 'package:yabalash_mobile_app/features/flyers/presentation/blocs/flyers_state.dart';

import '../../../../core/depedencies.dart';
import '../../../home/domain/entities/product.dart';
import '../../../product_details/domain/usecases/get_product_details_usecase.dart';
import '../../domain/entities/Flyer.dart';
import '../../domain/entities/FlyerProduct.dart';

class FlyersCubit extends Cubit<FlyersState> {
  final GetFlyersUseCase getFlyersUseCase;
  final GetProductDetailsUseCase getProductDetailsUseCase;

  Map<int, List<FlyerProduct>> _sProducts = {};

  int _productsPageNumber = 1;

  FlyersCubit(
      {required this.getProductDetailsUseCase, required this.getFlyersUseCase})
      : super(const FlyersState());

  void setCurrFlyer(Flyer? f) {
    emit(state.copyWith(currFlyer: f));
  }

  void setCurrFlyerPage(int p) {
    emit(state.copyWith(currFlyerPage: p));
  }

  void _setIsLoading(bool isLoading) {
    emit(state.copyWith(flyersRequestState: RequestState.loading));
  }

  // void getFlyerProducts() async {
  //   _setIsLoading(true);
  //
  //   final response = await searchProductUsecase(
  //       SearchParams(searchName: searchName.trim(), page: _productsPageNumber));
  //
  //   response.fold((failure) {
  //     emit(state.copyWith(
  //         errorMessage: failure.message,
  //         searchProductsRequestState: RequestState.error));
  //   }, (result) {
  //     if (result.isNotEmpty) {
  //       _productsPageNumber++;
  //     }
  //     emit(state.copyWith(
  //         paginationLoading: false,
  //         chepeastProduct: const Product(),
  //         searchProductsRequestState: RequestState.loaded,
  //         searchProductsResult: _productsResult..addAll(result)));
  //   });
  // }

  void setSelectedFlyerProduct(Offset position, double diff) {
    FlyerProduct? selected = _getFlyerProductFromTouchEvent(position, diff);
    if (selected != null) {
      emit(state.copyWith(selectedFlyerProduct: selected));
    } else {
      emit(state.copyWith(selectedFlyerProduct: const FlyerProduct()));
    }
  }

  Future<Product?> setActiveProduct() async {
    if (state.selectedFlyerProduct?.productId != null) {
      final response = await getProductDetailsUseCase(GetProductDetailsParams(
          withNearStores: false,
          productId: state.selectedFlyerProduct!.productId!));
      if (response.isRight()) {
        final product = response.getOrElse(() => const Product());
        emit(state.copyWith(activeProduct: product));
        return product;
      } else {
        emit(state.copyWith(
            flyersRequestState: RequestState.error,
            flyersError: "حذث خطأ! حاول مرة اخري"));
        return null;
      }
    } else {
      return null;
    }
  }

  void removeSelectedProductFromCart(FlyerProduct p) {
    _sProducts = Map.from(state.selectedProducts!);
    List<FlyerProduct> pageSelected = _sProducts[state.currFlyerPage]!;
    FlyerProduct? selected = pageSelected.firstWhere(
        (element) => element.productId == p.productId,
        orElse: () => const FlyerProduct());
    if (selected.productId != null) {
      pageSelected.remove(selected);
      _sProducts[state.currFlyerPage!] = pageSelected;
      emit(state.copyWith(selectedProducts: _sProducts));
    }
  }

  int? getProductIdFromTouchEvent(
      Offset position, Flyer flyer, int pageIndex, double diff) {
    for (var productCoordinate in flyer.pages![pageIndex].products!) {
      if (position.dx >= (productCoordinate.x1y1!.x!) * diff &&
          position.dx <= (productCoordinate.x2y1!.x!) * diff &&
          position.dy <= (productCoordinate.x1y1!.y!) * diff &&
          position.dy >= (productCoordinate.x1y2!.y!) * diff) {
        return productCoordinate.productId;
      }
    }
    return null;
  }

  FlyerProduct? _getFlyerProductFromTouchEvent(Offset position, double diff) {
    for (var productCoordinate
        in state.currFlyer!.pages![state.currFlyerPage!].products!) {
      if (position.dx >= (productCoordinate.x1y1!.x!) * diff &&
          position.dx <= (productCoordinate.x2y1!.x!) * diff &&
          position.dy <= (productCoordinate.x1y1!.y!) * diff &&
          position.dy >= (productCoordinate.x1y2!.y!) * diff) {
        return productCoordinate;
      }
    }
    return null;
  }

  double? getStoreProductPrice() {
    return state.activeProduct!.prices!.values
        .firstWhere((element) => element.storeId == state.currFlyer!.store!.id!)
        .price;
  }

  void _selectActiveProduct() {
    _sProducts = Map.from(state.selectedProducts!);
    bool isProductSelected =
        checkIfItemSelected(state.selectedFlyerProduct!, state.currFlyerPage!);
    if (isProductSelected) {
      _sProducts[state.currFlyerPage!] =
          List.from(state.selectedProducts![state.currFlyerPage!] ?? [])
            ..remove(state.selectedFlyerProduct!);
    } else {
      _sProducts[state.currFlyerPage!] =
          List.from(state.selectedProducts![state.currFlyerPage!] ?? [])
            ..add(state.selectedFlyerProduct!);
    }
    emit(state.copyWith(selectedProducts: _sProducts));
  }

  void addActiveProductToCart() {
    getIt<CartCubit>().addItemToCart(state.activeProduct!);
    _selectActiveProduct();
  }

  bool checkIfItemSelected(FlyerProduct flyerProduct, int pageIndex) {
    bool isExist = false;
    FlyerProduct? item = state.selectedProducts![pageIndex]?.firstWhere(
      (element) => element.productId == flyerProduct.productId,
      orElse: () => const FlyerProduct(),
    );

    if (item?.productId != null) {
      isExist = true;
    }

    return isExist;
  }

  Future<List<Product>> getSelectedFlyerProducts() async {
    emit(state.copyWith(flyersRequestState: RequestState.loading));
    bool doContinue = true;
    List<Product> products = [];
    for (var fPage in state.selectedProducts!.values) {
      for (var fProduct in fPage) {
        if (!doContinue) break;
        final response = await getProductDetailsUseCase(GetProductDetailsParams(
            withNearStores: false, productId: fProduct.productId!));
        response.fold((failure) {
          emit(state.copyWith(
              flyersRequestState: RequestState.error,
              flyersError: failure.message));
          doContinue = false;
        }, (product) {
          products.add(product);
        });
      }
    }
    if (products.isEmpty == true) {
      emit(state.copyWith(
          flyersRequestState: RequestState.error,
          flyersError: "لم يتم تحديد اي منتج"));
    }
    return products;
  }

  void getFlyersList() async {
    final response = await getFlyersUseCase(NoParams());

    response.fold((failure) {
      emit(state.copyWith(
          flyersRequestState: RequestState.error,
          flyersError: failure.message));
    }, (flyers) {
      emit(state.copyWith(
          flyers: flyers, flyersRequestState: RequestState.loaded));
    });
  }
}
