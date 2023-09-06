import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yabalash_mobile_app/core/utils/get_flyer_status.dart';
import 'package:yabalash_mobile_app/core/utils/get_flyer_title.dart';
import 'package:yabalash_mobile_app/features/flyers/presentation/blocs/flyers_cubit.dart';
import 'package:yabalash_mobile_app/features/flyers/presentation/blocs/flyers_state.dart';

import '../../../../core/widgets/custom_card.dart';

class FlyerDetailsSection extends StatelessWidget {
  const FlyerDetailsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FlyersCubit, FlyersState>(builder: (context, state) {
      return Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
          child: Row(children: [
            CustomCard(
              imagePath: state.currFlyer!.store!.logoImagePath,
              fit: BoxFit.fill,
              isAssetImage: false,
              borderRadius: 10.r,
            ),
            Padding(
                padding: EdgeInsets.only(right: 10.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(state.currFlyer!.store!.name!,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontSize: 16.sp, fontWeight: FontWeight.w700)),
                    Row(
                      children: [
                        Container(
                            decoration: const BoxDecoration(
                                color: Color(0xFFFBE8EA),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.w),
                                child: Text(
                                    getFlyerStatus(state.currFlyer!.endDate!),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.w600,
                                          color: const Color(0xFFCE3C4D),
                                        )))),
                        Padding(
                          padding: EdgeInsets.only(right: 10.w),
                          child: Text(
                              "من ${getFlyerTitle(state.currFlyer!.startDate!)} إلي ${getFlyerTitle(state.currFlyer!.endDate!)}",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    fontSize: 10.sp,
                                  )),
                        )
                      ],
                    )
                  ],
                ))
          ]));
    });
  }
}
