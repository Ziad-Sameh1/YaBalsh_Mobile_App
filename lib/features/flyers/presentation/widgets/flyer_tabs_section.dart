import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yabalash_mobile_app/features/flyers/presentation/blocs/flyers_cubit.dart';
import 'package:yabalash_mobile_app/features/flyers/presentation/blocs/flyers_state.dart';
import 'package:yabalash_mobile_app/features/flyers/presentation/widgets/flyer_products_tab.dart';

import 'flyer_pages_gallery.dart';

class FlyerTabs extends StatefulWidget {
  const FlyerTabs({super.key});

  @override
  State<StatefulWidget> createState() => _FlyerTabsState();
}

class _FlyerTabsState extends State<FlyerTabs>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  late int tabIndex;

  void setTabIndex(int index) {
    setState(() {
      tabIndex = index;
    });
  }

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      setTabIndex(_tabController.index);
    });
    super.initState();
  }

  @override
  void dispose() {
    setTabIndex(0);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FlyersCubit, FlyersState>(builder: (context, state) {
      return Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TabBar(
              unselectedLabelColor: Colors.black,
              labelColor: Theme
                  .of(context)
                  .primaryColor,
              tabs: const [
                Tab(
                  child: Text("مجلة العروض",
                      style: TextStyle(fontWeight: FontWeight.w600)),
                ),
                Tab(
                  child: Text("المنتجات",
                      style: TextStyle(fontWeight: FontWeight.w600)),
                ),
                Tab(
                  child: Text("مجلات أخري",
                      style: TextStyle(fontWeight: FontWeight.w600)),
                )
              ],
              controller: _tabController,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorColor: Theme
                  .of(context)
                  .primaryColor,
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  const FlyerPagesGallery(),
                  InkWell(child: const FlyerProductTab(), onTap: () {
                    // to do
                  }),
                  Text('مجلات عروض أخري')
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
