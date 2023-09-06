import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yabalash_mobile_app/features/flyers/presentation/widgets/flyer_body.dart';

import '../../domain/entities/Flyer.dart';

class FlyerView extends StatelessWidget {

  final Flyer flyer;

  const FlyerView({super.key, required this.flyer});

  @override
  Widget build(BuildContext context) => FlyerBody(flyer: flyer);

}