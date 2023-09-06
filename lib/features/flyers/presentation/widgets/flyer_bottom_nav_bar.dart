import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yabalash_mobile_app/features/flyers/presentation/blocs/flyers_state.dart';
import '../blocs/flyers_cubit.dart';

class FlyerBottomNavBar extends StatefulWidget {
  const FlyerBottomNavBar({super.key});

  @override
  State<StatefulWidget> createState() => _FlyerBottomNavBarState();
}

class _FlyerBottomNavBarState extends State<FlyerBottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FlyersCubit, FlyersState>(builder: (context, state) {
      return BottomAppBar(
          elevation: 10,
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child:
                  // Row(children: [
                  SizedBox(
                height: 45,
                child: ElevatedButton(
                    style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(30.0)))),
                    onPressed: () {
                      BlocProvider.of<FlyersCubit>(context)
                          .addActiveProductToCart();
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          "أضف إلى السلة",
                          style: TextStyle(fontSize: 12),
                        ),
                        Icon(Icons.add)
                      ],
                    )),
              )

              // ),
              // largeHorizontalSpace,
              // largeHorizontalSpace,
              // Flexible(
              //   flex: 1,
              //   child: SizedBox(
              //     height: 40,
              //     child: OutlinedButton(
              //         style: ButtonStyle(
              //             shape:
              //                 MaterialStateProperty.all<RoundedRectangleBorder>(
              //                     RoundedRectangleBorder(
              //                         borderRadius:
              //                             BorderRadius.circular(30.0)))),
              //         onPressed: () {},
              //         child: Row(
              //           crossAxisAlignment: CrossAxisAlignment.center,
              //           mainAxisAlignment: MainAxisAlignment.center,
              //           children: [
              //             Text(
              //               "شارك هذا العرض",
              //               style: TextStyle(
              //                   color: Theme.of(context).primaryColor,
              //                   fontSize: 12),
              //             ),
              //             Icon(Icons.ios_share,
              //                 color: Theme.of(context).primaryColor)
              //           ],
              //         )),
              //   ),
              // ),
              // ]),
              ));
    });
  }
}
