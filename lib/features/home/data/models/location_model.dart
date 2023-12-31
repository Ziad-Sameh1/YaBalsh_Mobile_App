import 'package:yabalash_mobile_app/features/home/domain/entities/location.dart';

class LocationModel extends Location {
  const LocationModel(
      {String? zone,
      String? address,
      double? lat,
      double? lon,
      int? mainZoneId,
      int? subZoneId,
      String? mapImage,
      String? startTime,
      String? endTime,
      String? deliveryFees,
      int? deliveryTime})
      : super(
            address: address,
            deliveryFees: deliveryFees,
            mainZoneId: mainZoneId,
            mapImage: mapImage,
            subZoneId: subZoneId,
            deliveryTime: deliveryTime,
            startTime: startTime,
            endTime: endTime,
            lat: lat,
            lon: lon,
            zone: zone);

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
        zone: json['zone'] ?? '',
        mainZoneId: json['mainZoneId'] ?? 0,
        subZoneId: json['subZoneId'] ?? 0,
        mapImage: json['mapImagePath'] ?? '',
        deliveryFees: json['deliveryFees'] ?? '35',
        address: json['address'] ?? '',
        lat: json['lat'] != null
            ? json['lat'].runtimeType == String
                ? double.parse(json['lat'] as String)
                : json['lat']
            : 21.33333,
        lon: json['long'] != null
            ? json['long'].runtimeType == String
                ? double.parse(json['long'] as String)
                : json['long']
            : 23.33333,
        deliveryTime: json['deliveryTime'] ?? 95,
        startTime: json['startTime'] ?? '11:00 am',
        endTime: json['endTime'] ?? '12:00 am');
  }
}
