import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:yabalash_mobile_app/features/flyers/domain/entities/FlyerProduct.dart';

class FlyerSelectionPainter extends CustomPainter {
  final FlyerProduct p;

  const FlyerSelectionPainter({required this.p});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;
    // canvas.drawRect(const Offset(0, 32) & const Size(100, 100), paint);
    const icon = Icons.check_circle;
    var builder = ParagraphBuilder(
        ParagraphStyle(fontFamily: icon.fontFamily, fontSize: 40, ))
      ..addText(String.fromCharCode(icon.codePoint));
    var para = builder.build();
    para.layout(const ParagraphConstraints(width: 40));
    final xOffset = p.x1y1!.x! + (p.x2y1!.x! - p.x1y1!.x!) / 2;
    final yOffset = p.x1y1!.y! + (p.x2y1!.y! - p.x1y2!.y!) / 2;
    canvas.drawParagraph(para, Offset(xOffset, yOffset));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

