import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:yabalash_mobile_app/core/widgets/yaBalash_toast.dart';
import 'package:yabalash_mobile_app/features/home/presentation/blocs/cubit/home_cubit.dart';
import 'package:yabalash_mobile_app/features/home/presentation/blocs/cubit/main_navigation_cubit.dart';
import 'package:yabalash_mobile_app/features/home/presentation/widgets/flyer_card.dart';

import '../../../../core/constants/app_layouts.dart';
import '../../../../core/theme/light/app_colors_light.dart';
import '../../../../core/utils/enums/request_state.dart';
import 'Title_row.dart';
import 'last_offers_card.dart';

class FlyerSection extends StatelessWidget {
  const FlyerSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state.flyersRequestState == RequestState.error) {
          yaBalashCustomToast(message: state.flyersError!, context: context);
        }
      },
      buildWhen: (previous, current) =>
          previous.flyersRequestState != current.flyersRequestState,
      builder: (context, state) {
        switch (state.flyersRequestState) {
          case RequestState.loading:
            return const FlyerSectionLoading();
          case RequestState.loaded:
            return state.flyers!.isEmpty
                ? const SizedBox()
                : const FlyerSectionLoaded();

          case RequestState.error:
            return largeVerticalSpace;

          default:
            return const SizedBox();
        }
      },
    );
  }
}

class FlyerSectionLoaded extends StatelessWidget {
  const FlyerSectionLoaded({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TitleRow(
                fontWeight: FontWeight.w700,
                title: 'مجلات العروض',
                onSelectAll: () => BlocProvider.of<MainNavigationCubit>(context)
                    .changePage(1)),
            mediumVerticalSpace,
            SizedBox(
              height: 160.h,
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                padding: kScaffoldPadding,
                scrollDirection: Axis.horizontal,
                itemCount: state.flyers!.length,
                itemBuilder: (context, index) {
                  final flyer = state.flyers![index];
                  return FlyerCard(flyer: flyer);
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

class FlyerSectionLoading extends StatelessWidget {
  const FlyerSectionLoading({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140.h,
      child: ListView.builder(
        padding: kScaffoldPadding,
        scrollDirection: Axis.horizontal,
        itemCount: 6,
        itemBuilder: (context, index) {
          return Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade400,
            child: Container(
              width: 80.w,
              height: 100.h,
              margin: EdgeInsets.only(left: 10.w),
              decoration: BoxDecoration(
                  color: AppColorsLight.kMainCategoryCardColor,
                  borderRadius: kDefaultBorderRaduis),
            ),
          );
        },
      ),
    );
  }
}
