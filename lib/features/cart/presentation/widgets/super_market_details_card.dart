import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_layouts.dart';
import '../../../../core/theme/light/app_colors_light.dart';
import '../../../../core/widgets/custom_card.dart';
import '../../../../core/widgets/custom_svg_icon.dart';
import '../../domain/entities/supermarket_card_model.dart';

class SupermarketDetailsCard extends StatelessWidget {
  final SuperMarketCardModel superMarketCardModel;
  const SupermarketDetailsCard({super.key, required this.superMarketCardModel});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomCard(
          withBorder: true,
          isAssetImage: false,
          imagePath: superMarketCardModel.store!.cardImagePath,
        ),
        smallHorizontalSpace,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(children: [
                TextSpan(
                    text: 'طلبك من  ',
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: Colors.black, fontSize: 10.sp)),
                TextSpan(
                    text: superMarketCardModel.store!.name,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColorsLight.kAppPrimaryColorLight,
                        fontWeight: FontWeight.w600,
                        fontSize: 14.sp)),
              ]),
            ),
            mediumVerticalSpace,
            Row(
              children: [
                CustomSvgIcon(
                  iconPath: AppAssets.truckIcon,
                  height: 15.h,
                  color: AppColorsLight.kAppPrimaryColorLight,
                ),
                Text(
                  'الطلب هيتم توصيله في خلال 32 دقيقة',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color:
                          AppColorsLight.kAppPrimaryColorLight.withOpacity(0.8),
                      fontSize: 9.sp),
                )
              ],
            )
          ],
        )
      ],
    );
  }
}
