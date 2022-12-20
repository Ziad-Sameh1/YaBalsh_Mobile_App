import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:yabalash_mobile_app/features/home/domain/entities/price_model.dart';
part 'product.g.dart';

@HiveType(typeId: 3)
class Product extends Equatable {
  @HiveField(18)
  final int? id;
  @HiveField(9)
  final String? name;
  @HiveField(10)
  final String? imagePath;
  @HiveField(19)
  final String? size;

  @HiveField(13)
  final Map<String, PriceModel>? prices;

  const Product({this.id, this.name, this.imagePath, this.size, this.prices});

  @override
  List<Object?> get props => [id, name, imagePath, size, prices];
}
