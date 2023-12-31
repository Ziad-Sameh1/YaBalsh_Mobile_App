import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_layouts.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/theme/light/app_colors_light.dart';
import '../../../../core/utils/enums/search_navigation_screens.dart';
import '../../../../core/widgets/custom_card.dart';
import '../../../../core/widgets/stock_icon.dart';
import '../../../home/domain/entities/store.dart';

class PriceComparisonCard extends StatelessWidget {
  final double price;
  final Store store;
  final bool isAvailable;

  const PriceComparisonCard({
    super.key,
    required this.store,
    required this.price,
    required this.isAvailable,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return InkWell(
        onTap: () => Get.toNamed(RouteHelper.getSearchRoute(),
            arguments: [SearchNavigationScreens.storeScreen, store.name, 0]),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 15.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomCard(
                    height: 45.h,
                    width: 45.h,
                    withBorder: true,
                    isAssetImage: false,
                    imagePath: store.logoImagePath,
                  ),
                  mediumHorizontalSpace,

                  SizedBox(
                    width: constraints.maxWidth * 0.44,
                    child: Row(
                      children: [
                        Container(
                          constraints: BoxConstraints(
                              maxWidth: constraints.maxWidth * 0.38),
                          child: Text(
                            store.name ?? 'غير متوفر',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color:
                                        AppColorsLight.kAppPrimaryColorLight),
                          ),
                        ),
                        StockIcon(
                          isAvailable: isAvailable,
                        )
                      ],
                    ),
                  ),
                  // const Spacer(),
                  SizedBox(
                    width: constraints.maxWidth * 0.29,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          '${price.toStringAsFixed(2)} جنيه',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18.sp,
                                  color: AppColorsLight.kAppPrimaryColorLight),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Container(
                    margin: EdgeInsets.only(top: 3.h),
                    child: Icon(
                      Icons.arrow_forward_ios,
                      size: 18.h,
                      color: AppColorsLight.kAppPrimaryColorLight,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
