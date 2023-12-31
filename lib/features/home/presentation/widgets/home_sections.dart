import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:yabalash_mobile_app/core/constants/app_layouts.dart';
import 'package:yabalash_mobile_app/core/routes/app_routes.dart';
import 'package:yabalash_mobile_app/core/utils/enums/search_navigation_screens.dart';
import 'package:yabalash_mobile_app/core/widgets/error_indicator.dart';
import 'package:yabalash_mobile_app/core/widgets/kew_word_products.dart';
import 'package:yabalash_mobile_app/features/home/presentation/blocs/cubit/home_cubit.dart';

import '../../../../core/utils/enums/request_state.dart';
import '../../../../core/widgets/yaBalash_toast.dart';
import '../../domain/entities/product.dart';
import 'Title_row.dart';
import 'section_loading.dart';

class HomeSections extends StatelessWidget {
  const HomeSections({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state.homeSectionsRequestState == RequestState.error) {
          yaBalashCustomToast(
              message: 'فشل في جلب القوائم الرئيسية', context: context);
        }
      },
      buildWhen: (previous, current) =>
          previous.homeSectionsRequestState != current.homeSectionsRequestState,
      builder: (context, state) {
        switch (state.homeSectionsRequestState) {
          case RequestState.loading:
            return const HomeSectionsLoading();

          case RequestState.loaded:
            return state.homeSections!.isEmpty
                ? const SizedBox()
                : const HomeSectionsLoaded();

          case RequestState.error:
            return SizedBox(
                height: Get.height * 0.6,
                child: Center(
                    child: ErrorIndicator(errorMessage: state.sectionsError!)));

          default:
            return const SizedBox.shrink();
        }
      },
    );
  }
}

class HomeSectionsLoaded extends StatelessWidget {
  const HomeSectionsLoaded({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Column(
          children: state.homeSections!
              .map((homeSection) => SectionLoaded(
                  sectionId: homeSection.section!.id!,
                  sectionName: homeSection.section!.name!,
                  sectionProducts: homeSection.products!))
              .toList(),
        );
      },
    );
  }
}

class HomeSectionsLoading extends StatelessWidget {
  const HomeSectionsLoading({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        children: List.generate(3, (index) => const SectionLoading()));
  }
}

class SectionLoaded extends StatelessWidget {
  const SectionLoaded({
    Key? key,
    required this.sectionName,
    required this.sectionProducts,
    required this.sectionId,
  }) : super(key: key);

  final String sectionName;
  final int sectionId;
  final List<Product> sectionProducts;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        smallVerticalSpace,
        TitleRow(
          fontWeight: FontWeight.w700,
          title: sectionName,
          onSelectAll: () => Get.toNamed(RouteHelper.getSearchRoute(),
              arguments: [
                SearchNavigationScreens.sections,
                sectionName,
                sectionId
              ]),
        ),
        mediumVerticalSpace,
        KewordProducts(
          products: sectionProducts,
          isWithPadding: true,
        )
      ],
    );
  }
}
