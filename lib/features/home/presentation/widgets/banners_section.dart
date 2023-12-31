import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yabalash_mobile_app/core/routes/app_routes.dart';
import 'package:yabalash_mobile_app/core/utils/enums/search_navigation_screens.dart';
import 'package:yabalash_mobile_app/core/widgets/custom_network_image.dart';

import '../../../../core/constants/app_layouts.dart';
import '../../../../core/utils/enums/request_state.dart';
import '../../../../core/widgets/yaBalash_toast.dart';
import '../blocs/cubit/home_cubit.dart';
import 'banners_loading.dart';

class BannersSection extends StatelessWidget {
  const BannersSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state.bannersRequestState == RequestState.error) {
          yaBalashCustomToast(message: state.bannersError!, context: context);
        }
      },
      buildWhen: (previous, current) =>
          previous.bannersRequestState != current.bannersRequestState,
      builder: (context, state) {
        switch (state.bannersRequestState) {
          case RequestState.loading:
            return const BannersLoading();

          case RequestState.loaded:
            return const BannersLoaded();

          case RequestState.error:
            return const SizedBox();

          default:
            return SizedBox(
              height: 133.h,
            );
        }
      },
    );
  }
}

class BannersLoaded extends StatelessWidget {
  const BannersLoaded({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) =>
          previous.bannersRequestState != current.bannersRequestState,
      builder: (context, state) => state.banners!.isEmpty
          ? const SizedBox()
          : Column(
              children: [
                CarouselImage(state: state),
                mediumVerticalSpace,
              ],
            ),
    );
  }
}

class CarouselImage extends StatelessWidget {
  final HomeState state;
  const CarouselImage({
    Key? key,
    required this.state,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
        carouselController: CarouselController(),
        itemCount: state.banners!.length,
        itemBuilder: (context, index, realIndex) {
          final banner = state.banners![index];
          return InkWell(
            onTap: () => Get.toNamed(RouteHelper.getSearchRoute(), arguments: [
              SearchNavigationScreens.sections,
              banner.section!.name,
              banner.section!.id
            ]),
            child: ClipRRect(
              borderRadius: kDefaultBorderRaduis,
              child: Container(
                width: Get.width * 0.96,
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: AppImage(
                  path: banner.imagePath!,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          );
        },
        options: CarouselOptions(
            viewportFraction: 0.86,
            scrollPhysics: const BouncingScrollPhysics(),
            autoPlay: true,
            height: 133.h));
  }
}
