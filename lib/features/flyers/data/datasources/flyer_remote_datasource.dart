import 'dart:convert';

import 'package:yabalash_mobile_app/core/api/remote_data_api/endpoints.dart';
import 'package:yabalash_mobile_app/core/api/remote_data_api/rest_api_provider.dart';
import 'package:yabalash_mobile_app/features/flyers/data/models/flyers_response_model.dart';

import '../models/flyer_response_model.dart';

abstract class FlyerRemoteDataSource {
  Future<FlyersResponseModel> getFlyers({int? page});
  Future<FlyerResponseModel> getFlyerById({required int id});
}

class FlyerRemoteDataSourceImpl extends FlyerRemoteDataSource {
  final RestApiProvider restApiProvider;

  FlyerRemoteDataSourceImpl({required this.restApiProvider});

  @override
  Future<FlyersResponseModel> getFlyers({int? page}) async {
    // final response = await restApiProvider.get(getFlyersEndpoint());
    // const data =
    //     '{"success":true,"message":"test response","data":[{"id":1,"store":{"id":1,"name":"كارفور","cardImagePath":"https://yabalash.net/storage/DiWRortqJRjM16pNbXKgML1S40cckI-metaQ2FycmVmb3VyLnBuZw==-.png","logoImagePath":"https://yabalash.net/storage/qDJ6qwwNnVJRfH7R0ytXJuX52E3FLR-metaQTE3RTMwRjAtM0U5NS00QUExLUFEMjAtMUFCRDRFRjU1RjZELmpwZWc=-.jpg","location":{"mainZoneId":1,"subZoneId":23,"mapImagePath":"https://yabalash.net/storage/LJXpOF9f5X4srYIXCAGgza55yDl3V3-metaVW50aXRsZWQgZGVzaWduKDEyNykucG5n-.png","address":"مدينتي - سيزونز بارك مول","lat":30.078098,"long":31.666976,"deliveryTime":80,"deliveryFees":"20.00","startTime":"09:00 am","endTime":"12:00 am"}},"pages":[{"page_id":1,"image":"https://i.ibb.co/7KqWrtn/carrefouregypt910699825512212046587686758768-1.jpg","products":[{"product_id":1,"x1y1":{"x":28.0,"y":585.0},"x1y2":{"x":28.0,"y":400.0},"x2y1":{"x":298.0,"y":585.0},"x2y2":{"x":298.0,"y":400.0}},{"product_id":2,"x1y1":{"x":300.0,"y":585.0},"x1y2":{"x":300.0,"y":400.0},"x2y1":{"x":570.0,"y":585.0},"x2y2":{"x":570.0,"y":400.0}},{"product_id":3,"x1y1":{"x":28.0,"y":775.0},"x1y2":{"x":28.0,"y":590.0},"x2y1":{"x":207.0,"y":775.0},"x2y2":{"x":207.0,"y":590.0}},{"product_id":4,"x1y1":{"x":211.0,"y":775.0},"x1y2":{"x":211.0,"y":590.0},"x2y1":{"x":387.0,"y":775.0},"x2y2":{"x":387.0,"y":590.0}},{"product_id":5,"x1y1":{"x":392.0,"y":775.0},"x1y2":{"x":392.0,"y":590.0},"x2y1":{"x":572.0,"y":775.0},"x2y2":{"x":572.0,"y":590.0}}]},{"page_id":1,"image":"https://i.ibb.co/7KqWrtn/carrefouregypt910699825512212046587686758768-1.jpg","products":[{"product_id":1,"x1y1":{"x":28.0,"y":585.0},"x1y2":{"x":28.0,"y":400.0},"x2y1":{"x":298.0,"y":585.0},"x2y2":{"x":298.0,"y":400.0}},{"product_id":2,"x1y1":{"x":300.0,"y":585.0},"x1y2":{"x":300.0,"y":400.0},"x2y1":{"x":570.0,"y":585.0},"x2y2":{"x":570.0,"y":400.0}},{"product_id":3,"x1y1":{"x":28.0,"y":775.0},"x1y2":{"x":28.0,"y":590.0},"x2y1":{"x":207.0,"y":775.0},"x2y2":{"x":207.0,"y":590.0}},{"product_id":4,"x1y1":{"x":211.0,"y":775.0},"x1y2":{"x":211.0,"y":590.0},"x2y1":{"x":387.0,"y":775.0},"x2y2":{"x":387.0,"y":590.0}},{"product_id":5,"x1y1":{"x":392.0,"y":775.0},"x1y2":{"x":392.0,"y":590.0},"x2y1":{"x":572.0,"y":775.0},"x2y2":{"x":572.0,"y":590.0}}]}],"start_date":"22-06-2023 05:57:58 PM","end_date":"31-08-2023 05:57:58 PM"},{"id":2,"store":{"id":1,"name":"كارفور","cardImagePath":"https://yabalash.net/storage/DiWRortqJRjM16pNbXKgML1S40cckI-metaQ2FycmVmb3VyLnBuZw==-.png","logoImagePath":"https://yabalash.net/storage/qDJ6qwwNnVJRfH7R0ytXJuX52E3FLR-metaQTE3RTMwRjAtM0U5NS00QUExLUFEMjAtMUFCRDRFRjU1RjZELmpwZWc=-.jpg","location":{"mainZoneId":1,"subZoneId":23,"mapImagePath":"https://yabalash.net/storage/LJXpOF9f5X4srYIXCAGgza55yDl3V3-metaVW50aXRsZWQgZGVzaWduKDEyNykucG5n-.png","address":"مدينتي - سيزونز بارك مول","lat":30.078098,"long":31.666976,"deliveryTime":80,"deliveryFees":"20.00","startTime":"09:00 am","endTime":"12:00 am"}},"pages":[{"page_id":1,"image":"https://i.ibb.co/D4x17Jn/web-BIM-17-08-2023-page-0.jpg","products":[{"product_id":512,"x1y1":{"x":1.2,"y":1.5},"x1y2":{"x":1.2,"y":1.5},"x2y1":{"x":1.2,"y":1.5},"x2y2":{"x":1.2,"y":1.5}}]}],"start_date":"01-07-2023 05:57:58 PM","end_date":"22-04-2021 05:57:58 PM"}]}';
    // final response = json.decode(data);
    
    final response = await restApiProvider.get(getFlyersEndpoint(), queryParams: {'page': page});

    return FlyersResponseModel.fromJson(response);
  }

  @override
  Future<FlyerResponseModel> getFlyerById({required int id}) async {
    final response = await restApiProvider.get(getFlyerEndpointById(id));
    
    return FlyerResponseModel.fromJson(response);
  }
}
