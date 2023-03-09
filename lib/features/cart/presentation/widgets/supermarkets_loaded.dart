import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:yabalash_mobile_app/core/depedencies.dart';
import 'package:yabalash_mobile_app/core/services/app_settings_service.dart';

import '../../../../core/constants/app_layouts.dart';
import '../../../../core/utils/enums/empty_states.dart';
import '../../../../core/widgets/empty_indicator.dart';
import '../blocs/cubit/super_markets_cubit.dart';
import 'supermarkets_section.dart';

class SuperMarketsLoaded extends StatelessWidget {
  const SuperMarketsLoaded({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SuperMarketsCubit, SuperMarketsState>(
      builder: (context, state) {
        return Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: getIt<AppSettingsService>().appConfig.appVersion !=
                      '2.0.0' // complete version no padding (EdgeInsets.zero)
                  ? kDefaultPadding
                  : EdgeInsets.zero,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  state.availableSupermarkets!.isEmpty &&
                          state.unAvailableSupermarkets!.isEmpty
                      ? SizedBox(
                          height: getIt<AppSettingsService>()
                                      .appConfig
                                      .appVersion !=
                                  '2.0.0' // complete version height(0.6)
                              ? Get.height
                              : Get.height * 0.6,
                          child: const Center(
                            child: EmptyIndicator(
                                emptyStateType: EmptyStates.cart,
                                title: 'لا يوجد سوبرماركتس لطلب المنتجات'),
                          ),
                        )
                      : const SupermarketsSection(
                          isAvailableMarkets: true,
                        ),
                  state.unAvailableSupermarkets!.isEmpty
                      ? const SizedBox()
                      : const SupermarketsSection(
                          isAvailableMarkets: false,
                        ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
