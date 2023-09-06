import 'package:equatable/equatable.dart';

import 'FlyerProduct.dart';

class FlyerPage extends Equatable {
  final int? pageId;

  final List<FlyerProduct>? products;

  final String? image;

  const FlyerPage({this.pageId, this.products, this.image});

  @override
  List<Object?> get props => [pageId, products];

  factory FlyerPage.fromJson(Map<String, dynamic> json) => FlyerPage(
      pageId: json["page_id"],
      image: json["image"],
      products: (json["products"] as List<dynamic>)
          .map((e) => FlyerProduct.fromJson(e))
          .toList());
}
