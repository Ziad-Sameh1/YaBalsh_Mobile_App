// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:yabalash_mobile_app/core/constants/app_layouts.dart';
import 'package:yabalash_mobile_app/core/theme/light/app_colors_light.dart';

class TitleRow extends StatelessWidget {
  final String title;
  final VoidCallback? onSelectAll;
  final FontWeight? fontWeight;
  final EdgeInsets? padding;
  const TitleRow(
      {super.key,
      required this.title,
      this.onSelectAll,
      this.fontWeight,
      this.padding});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? kScaffoldPadding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(fontWeight: fontWeight),
          ),
          InkWell(
            onTap: onSelectAll,
            child: Text(
              "عرض الكل",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColorsLight.kAppPrimaryColorLight,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
