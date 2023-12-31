import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:yabalash_mobile_app/core/constants/app_layouts.dart';
import 'package:yabalash_mobile_app/features/search/presentation/widgets/products_search_section.dart';
import 'package:yabalash_mobile_app/features/search/presentation/widgets/search_header.dart';
import 'package:yabalash_mobile_app/features/search/presentation/widgets/super_markets_search_section.dart';

import '../../../../core/utils/enums/search_navigation_screens.dart';
import 'search_history_section.dart';
import 'search_type_section.dart';

class SearchBody extends StatelessWidget {
  final PageController pageController;
  final String? intialValue;
  final SearchNavigationScreens searchNavigationScreens;
  final GlobalKey<FormBuilderState> searchFormKey;
  const SearchBody(
      {super.key,
      required this.pageController,
      this.intialValue,
      required this.searchNavigationScreens,
      required this.searchFormKey});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SearchHeader(intialValue: intialValue!, searchFormKey: searchFormKey),
          SearchTypeSection(
              pageController: pageController, searchFormKey: searchFormKey),
          SearchHistorySection(
            searchFormKey: searchFormKey,
          ),
          smallVerticalSpace,
          Expanded(
            child: PageView.builder(
              physics: const NeverScrollableScrollPhysics(),
              controller: pageController,
              itemCount: searchPages.length,
              itemBuilder: (context, index) => searchPages[index],
            ),
          )
        ],
      ),
    );
  }
}

final List<Widget> searchPages = [
  const ProductsSearchSection(),
  const SuperMarketsSearchSection()
];
