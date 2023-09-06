import 'package:equatable/equatable.dart';
import 'package:yabalash_mobile_app/features/flyers/domain/entities/FlyerProductPoint.dart';

class FlyerProduct extends Equatable {
  final int? productId;
  final FlyerProductPoint? x1y1;
  final FlyerProductPoint? x1y2;
  final FlyerProductPoint? x2y1;
  final FlyerProductPoint? x2y2;

  const FlyerProduct(
      {this.productId, this.x1y1, this.x1y2, this.x2y1, this.x2y2});

  @override
  List<Object?> get props => [productId, x1y1, x1y2, x2y1, x2y2];

  factory FlyerProduct.fromJson(Map<String, dynamic> json) => FlyerProduct(
      productId: json["product_id"],
      x1y1: FlyerProductPoint.fromJson(json["x1y1"]),
      x1y2: FlyerProductPoint.fromJson(json["x1y2"]),
      x2y1: FlyerProductPoint.fromJson(json["x2y1"]),
      x2y2: FlyerProductPoint.fromJson(json["x2y2"]));
}
