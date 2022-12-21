import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yabalash_mobile_app/core/constants/app_assets.dart';
import 'package:yabalash_mobile_app/core/widgets/custom_animated_widget.dart';
import 'package:yabalash_mobile_app/features/cart/presentation/views/cart_view.dart';
import 'package:yabalash_mobile_app/features/categories/presentation/views/category_view.dart';
import 'package:yabalash_mobile_app/features/home/presentation/blocs/cubit/home_cubit.dart';
import 'package:yabalash_mobile_app/features/home/presentation/blocs/cubit/main_navigation_cubit.dart';
import 'package:yabalash_mobile_app/features/home/presentation/views/home_view.dart';
import 'package:yabalash_mobile_app/features/home/presentation/widgets/nav_icon.dart';
import 'package:yabalash_mobile_app/features/settings/presentation/views/settings_view.dart';

import '../../../../core/depedencies.dart';
import '../../../cart/presentation/blocs/cubit/cart_cubit.dart';

class MainNavigation extends StatelessWidget {
  MainNavigation({super.key});

  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageView.builder(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: screens.length,
            itemBuilder: ((context, index) {
              return screens[index];
            })),
      ),
      bottomNavigationBar: MainBottomNavBar(
        pageController: _pageController,
      ),
    );
  }
}

class MainBottomNavBar extends StatelessWidget {
  final PageController pageController;

  const MainBottomNavBar({
    super.key,
    required this.pageController,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainNavigationCubit, MainNavigationState>(
      builder: (context, state) {
        return BottomNavigationBar(
          currentIndex:
              BlocProvider.of<MainNavigationCubit>(context).currentPageIndex,
          onTap: (value) {
            BlocProvider.of<MainNavigationCubit>(context).setPageIndex(value);
            pageController.animateToPage(value,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut);
          },
          items: [
            BottomNavigationBarItem(
                icon: NavIcon(
                    activeIndex: BlocProvider.of<MainNavigationCubit>(context)
                        .currentPageIndex,
                    iconPath: AppAssets.homeIcon,
                    itemIndex: 0),
                label: 'الرئيسية'),
            BottomNavigationBarItem(
                icon: NavIcon(
                    activeIndex: BlocProvider.of<MainNavigationCubit>(context)
                        .currentPageIndex,
                    iconPath: AppAssets.menuIcon,
                    itemIndex: 1),
                label: 'الاقسام'),
            BottomNavigationBarItem(
                icon: NavIcon(
                    activeIndex: BlocProvider.of<MainNavigationCubit>(context)
                        .currentPageIndex,
                    iconPath: AppAssets.cartIcon,
                    itemIndex: 2),
                label: 'السلة'),
            BottomNavigationBarItem(
                icon: NavIcon(
                    activeIndex: BlocProvider.of<MainNavigationCubit>(context)
                        .currentPageIndex,
                    iconPath: AppAssets.shoppingListsIcon,
                    itemIndex: 3),
                label: 'قوائمي'),
            BottomNavigationBarItem(
                icon: NavIcon(
                    activeIndex: BlocProvider.of<MainNavigationCubit>(context)
                        .currentPageIndex,
                    iconPath: AppAssets.settingsIcon,
                    itemIndex: 4),
                label: 'الاعدادت')
          ],
        );
      },
    );
  }
}

final List<Widget> screens = [
  BlocProvider<HomeCubit>(
    create: (context) {
      if (!getIt<HomeCubit>().isClosed) {
        return getIt<HomeCubit>()
          ..getLastOffers()
          ..getBanners()
          ..getNearStores()
          ..getFirstSection();
      }

      return getIt<HomeCubit>();
    },
    child: const CustomAnimatedWidget(child: HomeView()),
  ),
  const CustomAnimatedWidget(child: CategoriesScreen()),
  CustomAnimatedWidget(
    child: MultiBlocProvider(providers: [
      BlocProvider.value(value: getIt<CartCubit>()),
    ], child: const CartView()),
  ),
  const CustomAnimatedWidget(child: CategoriesScreen()),
  const CustomAnimatedWidget(child: SettingsView()),
];
