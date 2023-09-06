import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yabalash_mobile_app/core/constants/app_layouts.dart';
import 'package:yabalash_mobile_app/core/widgets/custom_header.dart';
import 'package:yabalash_mobile_app/features/flyers/presentation/widgets/flyer_details_section.dart';
import 'package:yabalash_mobile_app/features/flyers/presentation/widgets/flyer_tabs_section.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/utils/enums/request_state.dart';
import '../../../../core/widgets/yaBalash_toast.dart';
import '../../domain/entities/Flyer.dart';
import '../blocs/flyers_cubit.dart';
import '../blocs/flyers_state.dart';

class FlyerBody extends StatefulWidget {
  final Flyer flyer;

  final PageController pageController = PageController(initialPage: 0);

  FlyerBody({super.key, required this.flyer});

  @override
  State<StatefulWidget> createState() => _FlyerBodyState();
}

class _FlyerBodyState extends State<FlyerBody> {
  @override
  void initState() {
    BlocProvider.of<FlyersCubit>(context).setCurrFlyer(widget.flyer);
    super.initState();
  }

  @override
  void dispose() {
    BlocProvider.of<FlyersCubit>(context).setCurrFlyer(null);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FlyersCubit, FlyersState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              largeVerticalSpace,
              largeVerticalSpace,
              CustomHeader(
                iconPath: AppAssets.backIcon,
                title: "مجلة العروض - ${widget.flyer.store!.name!}",
              ),
              const FlyerDetailsSection(),
              const Divider(),
              const Expanded(child: FlyerTabs())
            ],
          );
        },
        listener: (context, state) => {
              if (state.flyersRequestState == RequestState.error)
                yaBalashCustomToast(
                    message: state.flyersError!, context: context)
              else if (state.flyersRequestState == RequestState.loading)
                const CircularProgressIndicator()
            });
  }
}
