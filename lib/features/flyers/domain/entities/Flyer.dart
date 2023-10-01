import 'package:equatable/equatable.dart';

import '../../../home/domain/entities/store.dart';
import 'FlyerPage.dart';

class Flyer extends Equatable {
  final int? flyerId;
  final String? name;
  final String? thumbnail;
  final int? storeId;
  final List<FlyerPage>? pages;
  final DateTime? startDate;
  final DateTime? endDate;

  const Flyer(
      {this.flyerId, this.name, this.thumbnail, this.storeId, this.pages, this.startDate, this.endDate});

  @override
  List<Object?> get props => [flyerId, name, thumbnail, storeId, pages, startDate, endDate];
}
