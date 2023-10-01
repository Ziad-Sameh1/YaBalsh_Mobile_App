import 'package:equatable/equatable.dart';

import 'FlyerProduct.dart';

class FlyerPage extends Equatable {
  final int? pageId;

  final List<FlyerProduct>? products;

  final String? image;

  final int? width;

  final int? height;

  const FlyerPage({this.pageId, this.products, this.image, this.width, this.height});

  @override
  List<Object?> get props => [pageId, products, image, width, height];

  factory FlyerPage.fromJson(Map<String, dynamic> json) => FlyerPage(
      pageId: json["id"],
      image: json["image"],
      width: json["width"],
      height: json["height"],
      products: (json["sections"] as List<dynamic>)
          .map((e) => FlyerProduct.fromJson(e))
          .toList());
}
