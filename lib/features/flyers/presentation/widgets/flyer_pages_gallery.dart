import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:yabalash_mobile_app/features/flyers/presentation/blocs/flyers_cubit.dart';
import 'package:yabalash_mobile_app/features/flyers/presentation/blocs/flyers_state.dart';
import 'package:yabalash_mobile_app/features/flyers/presentation/widgets/fade_transition.dart';
import 'package:yabalash_mobile_app/features/flyers/presentation/widgets/flyer_product_sheet.dart';

import '../../../../core/constants/app_layouts.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/utils/enums/request_state.dart';
import '../../../home/domain/entities/product.dart';
import '../../../home/presentation/widgets/flyers_section.dart';
import '../../domain/entities/FlyerProduct.dart';

class FlyerPagesGallery extends StatefulWidget {
  const FlyerPagesGallery({super.key});

  @override
  State<StatefulWidget> createState() => _FlyerPageGalleryState();
}

class _FlyerPageGalleryState extends State<FlyerPagesGallery> {
  late PageController _pageController;

  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void onPageChanged(int index) {
    BlocProvider.of<FlyersCubit>(context).setCurrFlyerPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FlyersCubit, FlyersState>(builder: (context, state) {
      switch (state.flyersRequestState) {
        case RequestState.loading:
          return const FlyerSectionLoading();
        case RequestState.loaded:
          return state.currFlyer == null
              ? const SizedBox()
              : Stack(
                  children: [
                    GestureDetector(
                        onTapDown: (event) async {
                          double screenWidth =
                              MediaQuery.of(context).size.width;
                          int imageWidth = state.currFlyer!.pages![0].width!;
                          double realX =
                              event.localPosition.dx * imageWidth / screenWidth;
                          double realY =
                              event.localPosition.dy * imageWidth / screenWidth;
                          BlocProvider.of<FlyersCubit>(context)
                              .setSelectedFlyerProduct(realX, realY);
                          Product? active =
                              await BlocProvider.of<FlyersCubit>(context)
                                  .setActiveProduct();
                          if (active != null &&
                              active.id != null &&
                              context.mounted) {
                            showModalBottomSheet(
                                backgroundColor: Colors.transparent,
                                context: context,
                                builder: (innerContext) =>
                                    BlocProvider<FlyersCubit>.value(
                                        value: BlocProvider.of<FlyersCubit>(
                                            context),
                                        child:
                                            const FlyerProductSheetContent()));
                          }
                        },
                        child: AspectRatio(
                          aspectRatio: 1 / 1.41,
                          child: PhotoViewGallery.builder(
                            scrollPhysics: const BouncingScrollPhysics(),
                            builder: (BuildContext context, int index) {
                              return PhotoViewGalleryPageOptions(
                                imageProvider: NetworkImage(
                                    state.currFlyer!.pages![index].image!),
                                minScale: PhotoViewComputedScale.contained,
                                maxScale: PhotoViewComputedScale.covered,
                                heroAttributes: PhotoViewHeroAttributes(
                                    tag:
                                        state.currFlyer!.pages![index].pageId!),
                              );
                            },
                            backgroundDecoration:
                                const BoxDecoration(color: Colors.white),
                            itemCount: state.currFlyer!.pages!.length,
                            loadingBuilder: (context, event) => const Center(
                              child: SizedBox(
                                width: 20.0,
                                height: 20.0,
                                child: CircularProgressIndicator(),
                              ),
                            ),
                            pageController: _pageController,
                            onPageChanged: onPageChanged,
                          ),
                        )),
                    if (state.selectedProducts![state.currFlyerPage!] != null &&
                        state.selectedProducts![state.currFlyerPage!]
                                ?.isNotEmpty ==
                            true)
                      for (var selection
                          in state.selectedProducts![state.currFlyerPage!]!)
                        _Selection(
                          p: selection,
                          ratio: MediaQuery.of(context).size.width /
                              state.currFlyer!.pages![0].width!,
                          currentPage: state.currFlyerPage!,
                        )
                  ],
                );

        case RequestState.error:
          return largeVerticalSpace;

        default:
          return const SizedBox();
      }
    });
  }
}

class _Selection extends StatelessWidget {
  final FlyerProduct p;

  final double ratio;

  final int currentPage;

  const _Selection(
      {required this.p, required this.ratio, required this.currentPage});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // _SelectionContainer(p: p, ratio: ratio, currentPage: currentPage),
        _SelectionContainerIcon(p: p, ratio: ratio, currentPage: currentPage)
      ],
    );
  }
}

class _SelectionContainer extends StatelessWidget {
  final FlyerProduct p;

  final double ratio;

  final int currentPage;

  const _SelectionContainer(
      {required this.p, required this.ratio, required this.currentPage});

  @override
  Widget build(BuildContext context) {
    return Positioned(
        left: _getContainerXPosition(p, ratio),
        top: _getContainerYPosition(p, ratio),
        child: InkWell(
            child: Container(
              width: _getContainerXSize(p, ratio),
              height: _getContainerYSize(p, ratio),
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.3),
                  border: Border.all(color: Theme.of(context).primaryColor)),
            ),
            onTap: () {
              BlocProvider.of<FlyersCubit>(context)
                  .removeSelectedProductFromCart(p);
            }));
  }
}

class _SelectionContainerIcon extends StatelessWidget {
  final FlyerProduct p;

  final double ratio;

  final int currentPage;

  const _SelectionContainerIcon(
      {required this.p, required this.ratio, required this.currentPage});

  @override
  Widget build(BuildContext context) {
    return Positioned(
        left: _getIconXPosition(p, ratio) - (_getIconSize(p, ratio) / 2),
        top: _getIconYPosition(p, ratio) - (_getIconSize(p, ratio) / 2),
        child: InkWell(
            child: Container(
              height: _getIconSize(p, ratio),
              width: _getIconSize(p, ratio),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).primaryColor.withOpacity(0.85),
              ),
              alignment: Alignment.center,
              child: Icon(
                Icons.check,
                color: Colors.white,
                size: _getIconSize(p, ratio) * 0.8,
              ),
            ),
            onTap: () {
              BlocProvider.of<FlyersCubit>(context)
                  .removeSelectedProductFromCart(p);
            }));
  }
}

double _getIconXPosition(FlyerProduct p, double ratio) {
  return (p.x1y1!.x! + (p.x2y1!.x! - p.x1y1!.x!) / 2) * ratio;
}

double _getIconYPosition(FlyerProduct p, double ratio) {
  return (p.x1y2!.y! + (p.x2y1!.y! - p.x1y2!.y!) / 2) * ratio;
}

double _getContainerXPosition(FlyerProduct p, double ratio) {
  return p.x1y1!.x! * ratio;
}

double _getContainerYPosition(FlyerProduct p, double ratio) {
  return ratio * p.x1y2!.y!;
}

double _getContainerXSize(FlyerProduct p, double ratio) {
  double? x1 = p.x1y1!.x! * ratio;
  double? x2 = p.x2y1!.x! * ratio;
  return (x2 - x1);
}

double _getContainerYSize(FlyerProduct p, double ratio) {
  double? y1 = p.x1y1!.y! * ratio;
  double? y2 = p.x1y2!.y! * ratio;
  return (y1 - y2);
}

double _getIconSize(FlyerProduct p, double ratio) {
  double width = (p.x2y1!.x! - p.x1y1!.x!) * ratio;
  double height = (p.x1y1!.x! - p.x1y2!.x!) * ratio;
  double min = width;
  if (width > height) {
    height = min;
  }
  return min * 0.3;
}
