part of 'super_markets_cubit.dart';

class SuperMarketsState extends Equatable {
  final RequestState? storeRequestState;
  final List<SuperMarketCardModel>? availableSupermarkets;
  final List<SuperMarketCardModel>? unAvailableSupermarkets;
  final Map<CartItem, Map<Store, double>>? supermarketsTable;
  final Map<int, Map<int, double>>? storeProducts;
  final List<Store>? tableHeaderRow;
  final int? selectedSupermarketIndex;

  const SuperMarketsState(
      {this.storeRequestState = RequestState.loading,
      this.availableSupermarkets = const [],
      this.unAvailableSupermarkets = const [],
      this.supermarketsTable = const {},
      this.storeProducts = const {},
      this.tableHeaderRow = const [],
      this.selectedSupermarketIndex = -1});

  SuperMarketsState copyWith(
      {RequestState? storeRequestState,
      List<SuperMarketCardModel>? availableSupermarkets,
      int? selectedSupermarketIndex,
      Map<CartItem, Map<Store, double>>? supermarketsTable,
      Map<int, Map<int, double>>? storeProducts,
      List<Store>? tableHeaderRow,
      List<SuperMarketCardModel>? unAvailableSupermarkets}) {
    return SuperMarketsState(
        selectedSupermarketIndex:
            selectedSupermarketIndex ?? this.selectedSupermarketIndex,
        storeRequestState: storeRequestState ?? this.storeRequestState,
        availableSupermarkets:
            availableSupermarkets ?? this.availableSupermarkets,
        unAvailableSupermarkets:
            unAvailableSupermarkets ?? this.unAvailableSupermarkets,
        tableHeaderRow: tableHeaderRow ?? this.tableHeaderRow,
        supermarketsTable: supermarketsTable ?? this.supermarketsTable,
        storeProducts: storeProducts ?? this.storeProducts);
  }

  @override
  List<Object> get props => [
        storeRequestState!,
        availableSupermarkets!,
        unAvailableSupermarkets!,
        supermarketsTable!,
        storeProducts!,
        tableHeaderRow!,
        selectedSupermarketIndex!,
      ];
}
