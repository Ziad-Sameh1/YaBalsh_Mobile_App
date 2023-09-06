import 'package:intl/intl.dart';
import 'package:yabalash_mobile_app/features/flyers/domain/entities/Flyer.dart';
import 'package:yabalash_mobile_app/features/home/data/models/store_model.dart';

import '../../../home/domain/entities/store.dart';
import '../../domain/entities/FlyerPage.dart';
import '../../domain/entities/FlyerProduct.dart';

class FlyerModel extends Flyer {
  const FlyerModel(
      {int? id,
      Store? store,
      List<FlyerPage>? pages,
      DateTime? startDate,
      DateTime? endDate})
      : super(
            flyerId: id,
            store: store,
            pages: pages,
            startDate: startDate,
            endDate: endDate);

  factory FlyerModel.fromJson(Map<String, dynamic> json) {
    return FlyerModel(
        id: json["id"],
        store: StoreModel.fromJson(json["store"]),
        pages: (json["pages"] as List<dynamic>)
            .map((e) => FlyerPage.fromJson(e))
            .toList(),
        startDate:
            DateFormat('dd-MM-yyyy hh:mm:ss a').parse(json["start_date"]),
        endDate: DateFormat('dd-MM-yyyy hh:mm:ss a').parse(json["end_date"]));
  }
}
