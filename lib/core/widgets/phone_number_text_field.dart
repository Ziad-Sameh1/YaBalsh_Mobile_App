import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/app_layouts.dart';
import '../theme/light/app_colors_light.dart';
import '../theme/light/light_theme.dart';

class PhoneTextField extends StatelessWidget {
  final String? intialValue;
  final String? title;
  final bool? readOnly;
  final bool? isFilled;
  final String? hintText;
  final Function(String?)? onChanged;
  final bool? hasError;
  final FormFieldValidator<String>? validator;
  const PhoneTextField(
      {super.key,
      this.intialValue,
      this.validator,
      this.hintText,
      this.readOnly = false,
      this.hasError = false,
      this.title,
      this.onChanged,
      this.isFilled = true});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 51.h,
      child: Container(
        decoration: isFilled!
            ? kFilledTextFieldDecoration
            : !hasError!
                ? kFilledTextFieldDecoration.copyWith(color: Colors.transparent)
                : kFilledTextFieldDecoration.copyWith(
                    color: Colors.transparent,
                    border: Border.all(
                        color: AppColorsLight.kErrorColor, width: 1)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: kDefaultPadding,
              child: Text(Country.parse('EG').flagEmoji,
                  style: TextStyle(fontSize: 27.sp)),
            ),
            Text(
              '2+',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontWeight: FontWeight.w600, fontSize: 15.sp),
            ),
            smallHorizontalSpace,
            Container(
              height: 25.h,
              width: 2.w,
              color: AppColorsLight.kTextFieldBorderColor,
            ),
            smallHorizontalSpace,
            Expanded(
              child: LayoutBuilder(builder: (context, constraints) {
                return SizedBox(
                  height: 45.h,
                  child: FormBuilderTextField(
                    onChanged: onChanged ?? (value) {},
                    validator: validator,
                    name: 'phoneNumber',
                    initialValue: intialValue,
                    keyboardType: TextInputType.phone,
                    readOnly: readOnly ?? false,
                    cursorHeight: 25.h,
                    cursorRadius: const Radius.circular(8),
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontWeight: FontWeight.w600),
                    cursorColor: AppColorsLight.kAppPrimaryColorLight,
                    decoration: InputDecoration(
                        hintText: hintText ?? '',
                        contentPadding: EdgeInsets.zero,
                        hintStyle: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(
                                fontWeight: FontWeight.w500,
                                color: AppColorsLight.kTextFieldBorderColor),
                        border: InputBorder.none),
                  ),
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}
