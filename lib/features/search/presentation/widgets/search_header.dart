import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yabalash_mobile_app/core/utils/enums/search_navigation_screens.dart';
import 'package:yabalash_mobile_app/features/search/presentation/blocs/cubit/search_cubit.dart';

import '../../../../core/constants/app_layouts.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/theme/light/app_colors_light.dart';
import '../../../../core/theme/light/light_theme.dart';

class SearchHeader extends StatefulWidget {
  final String intialValue;
  final GlobalKey<FormBuilderState> searchFormKey;
  const SearchHeader(
      {super.key, required this.intialValue, required this.searchFormKey});

  @override
  State<SearchHeader> createState() => _SearchHeaderState();
}

class _SearchHeaderState extends State<SearchHeader> {
  late TextEditingController controller;
  @override
  void initState() {
    controller = TextEditingController(text: widget.intialValue);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: kDefaultPadding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              flex: 8,
              child: FormBuilder(
                key: widget.searchFormKey,
                child: SizedBox(
                  height: 32.h,
                  child: Container(
                    decoration: kFilledTextFieldDecoration.copyWith(
                        border: Border.all(color: Colors.transparent)),
                    padding: EdgeInsets.symmetric(horizontal: 5.h),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            final searchValue = widget
                                .searchFormKey
                                .currentState
                                ?.fields['search']!
                                .value as String;
                            if (searchValue.isNotEmpty) {
                              BlocProvider.of<SearchCubit>(context)
                                  .saveSearch(searchValue);
                              BlocProvider.of<SearchCubit>(context)
                                  .search(searchValue);
                            }
                          },
                          child: const Icon(
                            Icons.search,
                            color: AppColorsLight.kCancelColor,
                          ),
                        ),
                        smallHorizontalSpace,
                        Expanded(
                          child: LayoutBuilder(builder: (context, constraints) {
                            return SizedBox(
                              height: 32.h,
                              child: FormBuilderTextField(
                                name: 'search',
                                controller: controller,
                                textDirection: TextDirection.rtl,
                                onSaved: (newValue) => controller.clear(),
                                onSubmitted: (value) {
                                  if (value!.isNotEmpty) {
                                    BlocProvider.of<SearchCubit>(context)
                                        .saveSearch(value);
                                    BlocProvider.of<SearchCubit>(context)
                                        .search(value);
                                  }
                                },
                                onTap: () {
                                  if (controller.text.isNotEmpty) {
                                    if (controller
                                            .text[controller.text.length - 1] !=
                                        ' ') {
                                      controller.text = ('${controller.text} ');
                                    }
                                    if (controller.selection ==
                                        TextSelection.fromPosition(TextPosition(
                                            offset:
                                                controller.text.length - 1))) {
                                      setState(() {});
                                    }
                                  }
                                },
                                onChanged: (value) {
                                  if (value!.isEmpty) {
                                    BlocProvider.of<SearchCubit>(context)
                                        .changeSearchIsEmpty(true);
                                    widget.searchFormKey.currentState!
                                        .fields['search']!
                                        .setState(() {});
                                  } else {
                                    BlocProvider.of<SearchCubit>(context)
                                        .changeSearchIsEmpty(false);
                                  }
                                },
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14.sp),
                                cursorColor:
                                    AppColorsLight.kAppPrimaryColorLight,
                                decoration: InputDecoration(
                                    isDense: true,
                                    contentPadding: EdgeInsets.zero,
                                    hintText: 'دور على منتج او سوبر ماركت',
                                    hintStyle: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14.sp,
                                            color: AppColorsLight.kCancelColor),
                                    border: InputBorder.none),
                              ),
                            );
                          }),
                        )
                      ],
                    ),
                  ),
                ),
              )),
          mediumHorizontalSpace,
          Expanded(
            flex: 1,
            child: InkWell(
              onTap: () {
                final route = (Get.routing.args[0] as SearchNavigationScreens);
                if (route == SearchNavigationScreens.notification) {
                  Get.toNamed(RouteHelper.getMainNavigationRoute(),
                      arguments: 0);
                } else {
                  Get.back();
                }
              },
              child: Text(
                'الغاء',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColorsLight.kCancelColor),
              ),
            ),
          )
        ],
      ),
    );
  }
}
