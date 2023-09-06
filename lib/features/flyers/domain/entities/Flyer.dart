import 'package:equatable/equatable.dart';

import '../../../home/domain/entities/store.dart';
import 'FlyerPage.dart';

class Flyer extends Equatable {
  final int? flyerId;
  final Store? store;
  final List<FlyerPage>? pages;
  final DateTime? startDate;
  final DateTime? endDate;

  const Flyer(
      {this.flyerId, this.store, this.pages, this.startDate, this.endDate});

  @override
  List<Object?> get props => [flyerId, store, pages, startDate, endDate];
}
