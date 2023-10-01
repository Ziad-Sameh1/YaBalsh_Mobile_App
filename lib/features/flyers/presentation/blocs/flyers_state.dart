import 'package:equatable/equatable.dart';
import 'package:yabalash_mobile_app/features/flyers/domain/entities/FlyerProduct.dart';

import '../../../../core/utils/enums/request_state.dart';
import '../../../home/domain/entities/product.dart';
import '../../../home/domain/entities/store.dart';
import '../../domain/entities/Flyer.dart';

class FlyersState extends Equatable {
  final List<Flyer>? flyers;
  final RequestState? flyersRequestState;
  final String? flyersError;
  final Map<int, List<FlyerProduct>>? selectedProducts;
  final Product? activeProduct;
  final FlyerProduct? selectedFlyerProduct;
  final Flyer? currFlyer;
  final int? currFlyerPage;
  final bool? paginationLoading;
  final List<Product>? flyerProducts;
  final Store? currFlyerStore;

  const FlyersState(
      {this.flyers = const [],
      this.flyersRequestState = RequestState.loading,
      this.flyersError = '',
      this.selectedProducts = const {},
      this.activeProduct,
      this.selectedFlyerProduct,
      this.currFlyer = const Flyer(),
      this.currFlyerPage = 0,
      this.paginationLoading = false,
      this.currFlyerStore = const Store(),
      this.flyerProducts = const []});

  FlyersState copyWith({
    List<Flyer>? flyers,
    RequestState? flyersRequestState,
    String? flyersError,
    Map<int, List<FlyerProduct>>? selectedProducts,
    Product? activeProduct,
    FlyerProduct? selectedFlyerProduct,
    Flyer? currFlyer,
    int? currFlyerPage,
    bool? paginationLoading,
    Store? currFlyerStore,
    List<Product>? flyerProducts,
  }) =>
      FlyersState(
          flyers: flyers ?? this.flyers,
          flyersError: flyersError ?? this.flyersError,
          flyersRequestState: flyersRequestState ?? this.flyersRequestState,
          selectedProducts: selectedProducts ?? this.selectedProducts,
          activeProduct: activeProduct ?? this.activeProduct,
          selectedFlyerProduct:
              selectedFlyerProduct ?? this.selectedFlyerProduct,
          currFlyer: currFlyer ?? this.currFlyer,
          currFlyerPage: currFlyerPage ?? this.currFlyerPage,
          paginationLoading: paginationLoading ?? this.paginationLoading,
          currFlyerStore: currFlyerStore ?? this.currFlyerStore,
          flyerProducts: flyerProducts ?? this.flyerProducts);

  @override
  List<Object?> get props => [
        flyers,
        flyersError,
        flyersRequestState,
        selectedProducts,
        activeProduct,
        selectedFlyerProduct,
        currFlyer,
        currFlyerPage,
        currFlyerStore
      ];
}
