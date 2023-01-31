import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yabalash_mobile_app/core/routes/app_routes.dart';

import '../../../../core/constants/app_layouts.dart';
import '../../../../core/theme/light/app_colors_light.dart';
import '../../../../core/theme/light/light_theme.dart';
import '../../../../core/widgets/custom_card.dart';
import '../../domain/entities/shopping_list.dart';

class ShoppingListCard extends StatelessWidget {
  final ShoppingList shoppingList;
  const ShoppingListCard({super.key, required this.shoppingList});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(RouteHelper.getShoppingListDetailsRoute(),
            arguments: [shoppingList]);
      },
      child: Container(
        margin: EdgeInsets.only(top: 15.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShoppingListProductsCard(shoppingList: shoppingList),
                mediumHorizontalSpace,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      shoppingList.name!,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColorsLight.kAppPrimaryColorLight),
                    ),
                    smallVerticalSpace,
                    Text(
                      '${shoppingList.products!.length} منتجات',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColorsLight.kAppPrimaryColorLight
                              .withOpacity(0.6)),
                    )
                  ],
                ),
              ],
            ),
            const Spacer(),
            Icon(
              Icons.arrow_forward_ios,
              size: 15.h,
              color: AppColorsLight.kAppPrimaryColorLight.withOpacity(0.8),
            )
          ],
        ),
      ),
    );
  }
}

class ShoppingListProductsCard extends StatelessWidget {
  const ShoppingListProductsCard({
    Key? key,
    required this.shoppingList,
  }) : super(key: key);

  final ShoppingList shoppingList;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 65.h,
        height: 65.h,
        decoration: kDefaultBoxDecoration.copyWith(
            border: Border.all(color: Colors.transparent),
            color: AppColorsLight.kDisabledButtonColor),
        child: ProductsGrid(shoppingList: shoppingList));
  }
}

class ProductsGrid extends StatelessWidget {
  const ProductsGrid({
    Key? key,
    required this.shoppingList,
  }) : super(key: key);

  final ShoppingList shoppingList;

  @override
  Widget build(BuildContext context) {
    if (shoppingList.products!.length >= 4) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Row(children: [
                CustomCard(
                  withBorder: false,
                  isAssetImage: false,
                  borderRadius: 6,
                  backgroundColor: Colors.white,
                  width: 23.w,
                  height: 23.h,
                  imagePath: shoppingList.products![0].product!.imagePath,
                ),
                const Spacer(),
                CustomCard(
                  withBorder: false,
                  isAssetImage: false,
                  borderRadius: 6,
                  backgroundColor: Colors.white,
                  width: 23.w,
                  height: 23.h,
                  imagePath: shoppingList.products![1].product!.imagePath,
                ),
              ]),
            ),
            Expanded(
                flex: 1,
                child: Row(children: [
                  CustomCard(
                    withBorder: false,
                    isAssetImage: false,
                    borderRadius: 6,
                    backgroundColor: Colors.white,
                    width: 23.w,
                    height: 23.h,
                    imagePath: shoppingList.products![2].product!.imagePath,
                  ),
                  const Spacer(),
                  CustomCard(
                    withBorder: false,
                    isAssetImage: false,
                    borderRadius: 6,
                    backgroundColor: Colors.white,
                    width: 23.w,
                    height: 23.h,
                    imagePath: shoppingList.products![3].product!.imagePath,
                  ),
                ]))
          ],
        ),
      );
    } else {
      switch (shoppingList.products!.length) {
        case 3:
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 3.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  CustomCard(
                    withBorder: false,
                    isAssetImage: false,
                    borderRadius: 6,
                    backgroundColor: Colors.white,
                    width: 23.w,
                    height: 23.h,
                    imagePath: shoppingList.products![0].product!.imagePath,
                  ),
                  const Spacer(),
                  CustomCard(
                    withBorder: false,
                    isAssetImage: false,
                    borderRadius: 6,
                    backgroundColor: Colors.white,
                    width: 23.w,
                    height: 23.h,
                    imagePath: shoppingList.products![1].product!.imagePath,
                  ),
                ]),
                smallVerticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: shoppingList.products!
                      .sublist(2)
                      .map((cartItem) => CustomCard(
                            withBorder: false,
                            isAssetImage: false,
                            borderRadius: 6,
                            backgroundColor: Colors.white,
                            width: 23.w,
                            height: 23.h,
                            imagePath: cartItem.product!.imagePath,
                          ))
                      .toList(),
                )
              ],
            ),
          );

        case 2:
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 3.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(),
                Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  CustomCard(
                    withBorder: false,
                    isAssetImage: false,
                    borderRadius: 6,
                    backgroundColor: Colors.white,
                    width: 23.w,
                    height: 23.h,
                    imagePath: shoppingList.products![0].product!.imagePath,
                  ),
                  const Spacer(),
                  CustomCard(
                    withBorder: false,
                    isAssetImage: false,
                    borderRadius: 6,
                    backgroundColor: Colors.white,
                    width: 23.w,
                    height: 23.h,
                    imagePath: shoppingList.products![1].product!.imagePath,
                  ),
                ]),
                const Spacer()
              ],
            ),
          );

        case 1:
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 6.w),
            child: CustomCard(
              withBorder: false,
              isAssetImage: false,
              borderRadius: 6,
              backgroundColor: Colors.white,
              width: 65.h,
              height: 65.h,
              imagePath: shoppingList.products![0].product!.imagePath,
            ),
          );

        default:
          return const SizedBox();
      }
    }

    // return Wrap(
    //   direction: Axis.horizontal,
    //   alignment: WrapAlignment.start,
    //   spacing: 1.w,
    //   runSpacing: 5.h,
    //   children: shoppingList.products!.length > 4
    //       ? shoppingList.products!
    //           .sublist(0, 4)
    //           .map((cartItem) => CustomCard(
    //                 withBorder: false,
    //                 isAssetImage: false,
    //                 borderRadius: 6,
    //                 backgroundColor: Colors.white,
    //                 width: 23.w,
    //                 height: 23.h,
    //                 imagePath: cartItem.product!.imagePath,
    //               ))
    //           .toList()
    //       : shoppingList.products!
    //           .map((cartItem) => CustomCard(
    //                 withBorder: false,
    //                 isAssetImage: false,
    //                 borderRadius: 6,
    //                 backgroundColor: Colors.white,
    //                 width: 25.w,
    //                 height: 25.h,
    //                 imagePath: cartItem.product!.imagePath,
    //               ))
    //           .toList(),
    // );
  }
}
