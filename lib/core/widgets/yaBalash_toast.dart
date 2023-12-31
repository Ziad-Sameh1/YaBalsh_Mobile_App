// ignore_for_file: file_names

import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yabalash_mobile_app/core/widgets/custom_toast.dart';

void yaBalashCustomToast(
    {required String message, required BuildContext context}) {
  showToastWidget(
    CustomToast(message: message),
    animation: StyledToastAnimation.slideFromRight,
    reverseAnimation: StyledToastAnimation.slideToRight,
    isIgnoring: false,
    context: context,
    axis: Axis.horizontal,
    animDuration: const Duration(milliseconds: 500),
    duration: const Duration(seconds: 5),
    alignment: Alignment(5, Get.height - 20),
  );
}
