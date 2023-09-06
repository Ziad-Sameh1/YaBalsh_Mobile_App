import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:yabalash_mobile_app/features/flyers/presentation/blocs/flyers_cubit.dart';
import 'package:yabalash_mobile_app/features/flyers/presentation/blocs/flyers_state.dart';
import 'package:yabalash_mobile_app/features/flyers/presentation/widgets/fade_transition.dart';
import 'package:yabalash_mobile_app/features/flyers/presentation/widgets/flyer_product_sheet.dart';

import '../../../../core/constants/constants.dart';
import '../../../home/domain/entities/product.dart';
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
      return Stack(
        children: [
          GestureDetector(
              onTapDown: (event) async {
                double width = MediaQuery.of(context).size.width;
                double diff = width / flyerPageWidth;
                BlocProvider.of<FlyersCubit>(context)
                    .setSelectedFlyerProduct(event.localPosition, diff);
                Product? active = await BlocProvider.of<FlyersCubit>(context)
                    .setActiveProduct();
                if (active != null && active.id != null && context.mounted) {
                  showModalBottomSheet(
                      backgroundColor: Colors.transparent,
                      context: context,
                      builder: (innerContext) =>
                          BlocProvider<FlyersCubit>.value(
                              value: BlocProvider.of<FlyersCubit>(context),
                              child: const FlyerProductSheetContent()));
                }
              },
              child: AspectRatio(
                aspectRatio: 1 / 1.41,
                child: PhotoViewGallery.builder(
                  scrollPhysics: const BouncingScrollPhysics(),
                  builder: (BuildContext context, int index) {
                    return PhotoViewGalleryPageOptions(
                      imageProvider:
                          NetworkImage(state.currFlyer!.pages![index].image!),
                      minScale: PhotoViewComputedScale.contained,
                      maxScale: PhotoViewComputedScale.covered,
                      heroAttributes: PhotoViewHeroAttributes(
                          tag: state.currFlyer!.pages![index].pageId!),
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
          if (state.selectedProducts![state.currFlyerPage!] != null)
            for (var selection
                in state.selectedProducts![state.currFlyerPage!]!)
              FadeTransitionWrapper(
                  child: _Selection(
                p: selection,
                diff: MediaQuery.of(context).size.width / flyerPageWidth,
                currentPage: state.currFlyerPage!,
              ))
        ],
      );
    });
  }
}

class _Selection extends StatelessWidget {
  final FlyerProduct p;

  final double diff;

  final int currentPage;

  const _Selection(
      {required this.p, required this.diff, required this.currentPage});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _SelectionContainer(p: p, diff: diff, currentPage: currentPage),
        _SelectionContainerIcon(p: p, diff: diff, currentPage: currentPage)
      ],
    );
  }
}

class _SelectionContainer extends StatelessWidget {
  final FlyerProduct p;

  final double diff;

  final int currentPage;

  const _SelectionContainer(
      {required this.p, required this.diff, required this.currentPage});

  @override
  Widget build(BuildContext context) {
    return Positioned(
        left: _getContainerXPosition(p, diff),
        top: _getContainerYPosition(p, diff),
        child: InkWell(
            child: Container(
              width: _getContainerXSize(p, diff),
              height: _getContainerYSize(p, diff),
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

  final double diff;

  final int currentPage;

  const _SelectionContainerIcon(
      {required this.p, required this.diff, required this.currentPage});

  @override
  Widget build(BuildContext context) {
    return Positioned(
        left: _getIconXPosition(p, diff) - (_getIconSize(p, diff) / 2),
        top: _getIconYPosition(p, diff) - (_getIconSize(p, diff) / 2),
        child: InkWell(
            child: Container(
              height: _getIconSize(p, diff),
              width: _getIconSize(p, diff),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).primaryColor,
              ),
              alignment: Alignment.center,
              child: Icon(
                Icons.check,
                color: Colors.white,
                size: _getIconSize(p, diff) * 0.8,
              ),
            ),
            onTap: () {
              BlocProvider.of<FlyersCubit>(context)
                  .removeSelectedProductFromCart(p);
            }));
  }
}

double _getIconXPosition(FlyerProduct p, double diff) {
  return (p.x1y1!.x! + (p.x2y1!.x! - p.x1y1!.x!) / 2) * diff;
}

double _getIconYPosition(FlyerProduct p, double diff) {
  return (p.x1y2!.y! + (p.x2y1!.y! - p.x1y2!.y!) / 2) * diff;
}

double _getContainerXPosition(FlyerProduct p, double diff) {
  return (p.x1y1!.x!) * diff;
}

double _getContainerYPosition(FlyerProduct p, double diff) {
  return (p.x1y2!.y!) * diff;
}

double _getContainerXSize(FlyerProduct p, double diff) {
  return (p.x2y1!.x! - p.x1y1!.x!) * diff;
}

double _getContainerYSize(FlyerProduct p, double diff) {
  return (p.x1y1!.y! - p.x1y2!.y!) * diff;
}

double _getIconSize(FlyerProduct p, double diff) {
  double width = (p.x2y1!.x! - p.x1y1!.x!) * diff;
  double height = (p.x1y1!.x! - p.x1y2!.x!) * diff;
  double min = width;
  if (width > height) {
    height = min;
  }
  return min * 0.3;
}
