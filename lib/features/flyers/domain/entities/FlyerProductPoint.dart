import 'package:equatable/equatable.dart';

class FlyerProductPoint extends Equatable {

  final double? x;
  final double? y;

  const FlyerProductPoint({
    this.x,
    this.y
});

  @override
  List<Object?> get props => [x,y];

  factory FlyerProductPoint.fromJson(Map<String, dynamic> json) => FlyerProductPoint(x: double.parse('${json["x"]}'), y: double.parse('${json["y"]}'));
}