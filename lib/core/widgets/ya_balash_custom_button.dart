import 'package:flutter/material.dart';
import 'package:yabalash_mobile_app/core/theme/light/light_theme.dart';
import 'package:yabalash_mobile_app/core/widgets/custom_svg_icon.dart';

class YaBalashCustomButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final bool? isWithIcon;
  final String? iconPath;
  final bool? isSecondaryButton;
  final bool? isDisabled;

  const YaBalashCustomButton(
      {super.key,
      required this.title,
      required this.onTap,
      this.isDisabled = false,
      this.iconPath,
      this.isSecondaryButton = false,
      this.isWithIcon = false});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: isSecondaryButton!
          ? kSecondaryButtonStyle
          : !isDisabled!
              ? kMainButtonStyle
              : kDisabledButtonStyle,
      onPressed: onTap,
      child: !isWithIcon!
          ? Text(title)
          : CustomSvgIcon(
              iconPath: iconPath!,
              color: Colors.white,
            ),
    );
  }
}
