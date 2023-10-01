import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:yabalash_mobile_app/core/widgets/custom_network_image.dart';
import 'package:yabalash_mobile_app/features/flyers/presentation/blocs/flyers_state.dart';

import '../../../../core/constants/app_layouts.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../home/domain/entities/product.dart';
import '../blocs/flyers_cubit.dart';

class FlyerProductSheetContent extends StatefulWidget {
  const FlyerProductSheetContent({super.key});

  @override
  State<StatefulWidget> createState() => _FlyerProductSheetContentState();
}

class _FlyerProductSheetContentState extends State<FlyerProductSheetContent> {
  late double? storePrice;

  @override
  void initState() {
    setState(() {
      storePrice = BlocProvider.of<FlyersCubit>(context).getStoreProductPrice();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FlyersCubit, FlyersState>(builder: (context, state) {
      return Container(
          height: MediaQuery.of(context).size.height * 0.25,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25.0),
              topRight: Radius.circular(25.0),
            ),
          ),
          child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Column(children: [
                mediumVerticalSpace,
                Row(
                  children: [
                    SizedBox(
                        height: 80,
                        width: 80,
                        child: AppImage(path: state.activeProduct!.imagePath)),
                    largeHorizontalSpace,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(state.activeProduct!.name!,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Theme.of(context).primaryColor)),
                        _FlyerPrice(price: storePrice ?? 0),
                        InkWell(
                          child: _FlyerSheetShowProductView(
                              product: state.activeProduct!),
                          onTap: () {
                            Get.toNamed(RouteHelper.getProductDetailsRoute(),
                                arguments: state.activeProduct!);
                          },
                        )
                      ],
                    )
                  ],
                ),
                mediumVerticalSpace,
                Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: ElevatedButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(30.0)))),
                        onPressed: () {
                          BlocProvider.of<FlyersCubit>(context)
                              .addActiveProductToCart();
                          Navigator.pop(context);
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              "أضف إلى السلة",
                              // style: TextStyle(fontSize: 14),
                            ),
                            Icon(Icons.add)
                          ],
                        )))
              ])));
    });
  }
}

class _FlyerPrice extends StatelessWidget {
  final double price;

  const _FlyerPrice({required this.price});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text("$price",
            style: const TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 21,
            )),
        smallHorizontalSpace,
        const Text("جنيه"),
      ],
    );
  }
}

class _FlyerSheetShowProductView extends StatelessWidget {
  final Product product;

  const _FlyerSheetShowProductView({required this.product});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "قارن الاسعار لهذا المنتج",
          style: TextStyle(fontSize: 14, color: Theme.of(context).primaryColor),
        ),
        smallHorizontalSpace,
        const Icon(
          Icons.arrow_forward_ios,
          size: 14,
        )
      ],
    );
  }
}
