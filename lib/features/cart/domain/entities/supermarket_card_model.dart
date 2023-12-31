import 'package:equatable/equatable.dart';

import '../../../home/domain/entities/store.dart';

class SuperMarketCardModel extends Equatable {
  final Store? store;
  final double? price;
  final double? saving;
  final bool? isAvailable;

  const SuperMarketCardModel(
      {this.isAvailable, this.store, this.price, this.saving});
  @override
  List<Object?> get props => [store, saving, price, isAvailable];
}
