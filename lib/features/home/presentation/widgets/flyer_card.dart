import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yabalash_mobile_app/core/utils/get_flyer_title.dart';

import '../../../../core/constants/app_layouts.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/theme/light/app_colors_light.dart';
import '../../../../core/utils/enums/search_navigation_screens.dart';
import '../../../../core/widgets/custom_card.dart';
import '../../../categories/domain/entities/category.dart';
import '../../../flyers/domain/entities/Flyer.dart';

class FlyerCard extends StatelessWidget {
  const FlyerCard({
    Key? key,
    required this.flyer,
  }) : super(key: key);

  final Flyer flyer;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () {
            Get.toNamed(RouteHelper.getFlyerRoute(), arguments: [flyer]);
            // TODO: navigate to flyer screen
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomCard(
                width: 90.w,
                height: 100.h,
                isAssetImage: false,
                fit: BoxFit.cover,
                imagePath: flyer.pages![0].image,
                // backgroundColor: AppColorsLight.kSubCategoryCardColor,
                withBorder: false,
              ),
              SizedBox(
                height: 5.h,
              ),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: 90.w,
                ),
                child: Text(
                  getFlyerTitle(flyer.startDate!),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w700, color: Colors.black),
                ),
              )
            ],
          ),
        ),
        mediumHorizontalSpace
      ],
    );
  }
}
