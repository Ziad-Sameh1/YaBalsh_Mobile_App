import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yabalash_mobile_app/core/constants/app_strings.dart';
import 'package:yabalash_mobile_app/core/theme/light/app_colors_light.dart';

TextStyle headingTextStyle =
    TextStyle(fontSize: 26.sp, fontWeight: FontWeight.w700);

TextStyle subHeadingTextStyle =
    TextStyle(fontSize: 23.sp, fontWeight: FontWeight.w700);

TextStyle regularTextStyle =
    TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600);

TextStyle bodyTextStyle =
    TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w400);

TextStyle kActivebuttonTextStyle = TextStyle(
    fontFamily: AppStrings.fontFamily,
    fontSize: 15.sp,
    fontWeight: FontWeight.w700,
    color: Colors.white);

TextStyle kDisabledbuttonTextStyle = TextStyle(
    fontFamily: AppStrings.fontFamily,
    fontSize: 15.sp,
    fontWeight: FontWeight.w600);

TextStyle kBottomNavbuttonTextStyle = TextStyle(
    fontFamily: AppStrings.fontFamily,
    fontSize: 11.sp,
    fontWeight: FontWeight.w500);

TextStyle kErrorTextStyle = TextStyle(
    fontSize: 13.sp,
    fontWeight: FontWeight.w600,
    color: AppColorsLight.kErrorColor);
