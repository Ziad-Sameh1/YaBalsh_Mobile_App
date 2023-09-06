import 'package:yabalash_mobile_app/core/api/remote_data_api/api_response_model.dart';
import 'package:yabalash_mobile_app/features/flyers/data/models/flyer_model.dart';

import '../../domain/entities/Flyer.dart';

class FlyerResponseModel extends ApiResponse {
  const FlyerResponseModel({String? message, bool? success, List<Flyer>? data})
      : super(message: message, success: success, data: data);

  factory FlyerResponseModel.fromJson(Map<String, dynamic> json) {
    final data = (json["data"] as List<dynamic>)
        .map((e) => FlyerModel.fromJson(e))
        .toList();
    return FlyerResponseModel(
        message: json["message"], success: json["success"], data: data);
  }
}
