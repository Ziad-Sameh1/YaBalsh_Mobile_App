import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_layouts.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/theme/light/app_colors_light.dart';
import '../../../../core/utils/enums/search_navigation_screens.dart';
import '../../../../core/widgets/custom_card.dart';
import '../../domain/entities/main_category.dart';

class LastOfferCard extends StatelessWidget {
  const LastOfferCard({
    Key? key,
    required this.mainCategory,
  }) : super(key: key);

  final MainCategory mainCategory;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () => Get.toNamed(RouteHelper.getSearchRoute(), arguments: [
            SearchNavigationScreens.categoriesScreen,
            mainCategory.name
          ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomCard(
                width: 65.w,
                height: 65.h,
                isAssetImage: false,
                imagePath: mainCategory.imagePath,
                backgroundColor: AppColorsLight.kSubCategoryCardColor,
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
                  mainCategory.name!,
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
