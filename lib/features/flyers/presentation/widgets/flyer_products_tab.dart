import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:yabalash_mobile_app/core/utils/enums/request_state.dart';
import 'package:yabalash_mobile_app/features/flyers/presentation/blocs/flyers_cubit.dart';
import 'package:yabalash_mobile_app/features/flyers/presentation/blocs/flyers_state.dart';

import '../../../../core/constants/app_layouts.dart';
import '../../../../core/depedencies.dart';
import '../../../../core/widgets/error_indicator.dart';
import '../../../../core/widgets/sub_heading.dart';
import '../../../../core/widgets/yaBalash_toast.dart';
import '../../../cart/presentation/blocs/cubit/cart_cubit.dart';
import '../../../home/presentation/widgets/main_product_card.dart';

class FlyerProductTab extends StatelessWidget {
  const FlyerProductTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FlyersCubit, FlyersState>(builder: (context, state) {
      switch (state.flyersRequestState) {
        case RequestState.loading:
          return SizedBox(
            height: Get.size.height * 0.6,
            child: const Center(
              child: CircularProgressIndicator.adaptive(),
            ),
          );
        case RequestState.idle:
        case RequestState.loaded:
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SubHeading(text: 'المنتجات'),
              mediumVerticalSpace,
              // Padding(
              //   padding: EdgeInsets.symmetric(horizontal: 5.w),
              //   child: Wrap(
              //     direction: Axis.horizontal,
              //     runSpacing: 21.h,
              //     spacing: 21.w,
              //     alignment: WrapAlignment.start,
              //     children: state.chepeastProduct!.id != null
              //         ? state.searchProductsResult!
              //             .where((element) =>
              //                 element.id != state.chepeastProduct!.id)
              //             .toList()
              //             .map((product) {
              //             return BlocProvider.value(
              //               value: getIt<CartCubit>(),
              //               child: MainProductCard(
              //                   product: product, fromSearch: true),
              //             );
              //           }).toList()
              //         : state.searchProductsResult!.map((product) {
              //             return BlocProvider.value(
              //               value: getIt<CartCubit>(),
              //               child: MainProductCard(
              //                   product: product, fromSearch: true),
              //             );
              //           }).toList(),
              //   ),
              // ),
              state.paginationLoading!
                  ? const Center(
                      child: CircularProgressIndicator.adaptive(),
                    )
                  : const SizedBox(),
              largeVerticalSpace,
            ],
          );
        case RequestState.error:
          return SizedBox(
              height: Get.height * 0.75,
              child: ErrorIndicator(errorMessage: state.flyersError ?? 'خطأ'));
        default:
          return const SizedBox();
      }
    }, listener: (context, state) {
      if (state.flyersRequestState == RequestState.error) {
        yaBalashCustomToast(message: state.flyersError!, context: context);
      }
    });
  }
}
