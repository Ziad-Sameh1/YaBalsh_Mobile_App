import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yabalash_mobile_app/core/widgets/custom_svg_icon.dart';

class PageViewItem extends StatelessWidget {
  final String title;
  final String subTitle;
  final String imagePath;

  const PageViewItem(
      {required this.subTitle,
      required this.imagePath,
      required this.title,
      super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .headlineMedium!
                .copyWith(color: Theme.of(context).primaryColor),
          ),
          SizedBox(
            height: 20.h,
          ),
          CustomSvgIcon(
            iconPath: imagePath,
            width: 306.w,
            height: 283.h,
            boxFit: BoxFit.fill,
          ),
          SizedBox(
            height: 10.h,
          ),
          SizedBox(
            width: 220.w,
            child: Text(
              subTitle,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: Theme.of(context).primaryColor),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
