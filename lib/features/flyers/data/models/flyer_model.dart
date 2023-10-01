import 'package:intl/intl.dart';
import 'package:yabalash_mobile_app/features/flyers/domain/entities/Flyer.dart';
import 'package:yabalash_mobile_app/features/home/data/models/store_model.dart';

import '../../../home/domain/entities/store.dart';
import '../../domain/entities/FlyerPage.dart';
import '../../domain/entities/FlyerProduct.dart';

class FlyerModel extends Flyer {
  const FlyerModel(
      {int? id,
      String? name,
      String? thumbnail,
      int? storeId,
      List<FlyerPage>? pages,
      DateTime? startDate,
      DateTime? endDate})
      : super(
            flyerId: id,
            name: name,
            thumbnail: thumbnail,
            storeId: storeId,
            pages: pages,
            startDate: startDate,
            endDate: endDate);

  factory FlyerModel.fromJson(Map<String, dynamic> json) {
    return FlyerModel(
        id: json["id"],
        name: json["name"],
        thumbnail: json["thumbnail"],
        storeId: json["store_id"],
        pages: json["pages"] == null ? null :  (json["pages"]  as List<dynamic>)
            .map((e) => FlyerPage.fromJson(e))
            .toList(),
        startDate:
            DateTime.parse(json["start_time"]),
        endDate: DateTime.parse(json["end_time"]));
  }
}
