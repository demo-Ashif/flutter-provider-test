import 'package:connection_status_bar/connection_status_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:footsapp/core/utils/images.dart';
import 'package:footsapp/core/view_models/bottom_nav_viewmodel.dart';
import 'package:footsapp/features/top_app_bar/appbar.dart';
import 'package:footsapp/features/user_profile/screens/user_profile_screen.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../user_profile/screens/profile_page_dummy.dart';
import '../widgets/custom_fab.dart';
import 'bottom_nav_items_holder.dart';
import 'bottom_nav_page_holder.dart';

class BottomNavContainer extends StatefulWidget {
  static const String SCREEN_ID = 'bottom_nav_container_screen';

  @override
  _BottomNavContainerState createState() => _BottomNavContainerState();
}

class _BottomNavContainerState extends State<BottomNavContainer> {
  final Map<int, Function> _pages = {
    0: () => ProfilePageDummy(),
    1: () => ProfilePageDummy(),
    3: () => ProfilePageDummy(),
    4: () => UserProfileScreen(),
  };

  final _bgImages = [
    "bg5.png",
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavPageHolder(
      bottomNavChildPage: Builder(
        builder: (_) => buildScaffold(),
      ),
    );
  }

  Widget buildScaffold() {
    return SafeArea(
      top: false,
      bottom: true,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        floatingActionButton: CustomFab(),
        body: Consumer<BottomNavViewModel>(
          builder: (context, viewmodel, child) {
            return Stack(
              children: [
                buildBackground(),
                Column(
                  children: [
                    MyAppBar(),
                    Expanded(
                      child: Builder(
                        builder: (_) => _pages[viewmodel.currentPage](),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: BottomNavItemsHolder(
                        callback: (int index) {
                          viewmodel.currentPage = index;
                        },
                        currentIndex: viewmodel.currentPage,
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: ConnectionStatusBar(
                    height: 25,
                    width: double.maxFinite,
                    color: Colors.redAccent,
                    endOffset: const Offset(0.0, 0.0),
                    beginOffset: const Offset(0.0, -1.0),
                    animationDuration: const Duration(milliseconds: 200),
                    title: const Text(
                      'Please check your internet connection',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget buildBackground() {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: const Color(0xFF121212),
      child: FadeInImage(
        image: AssetImage("${Images.assetImagesPath}/${_bgImages[0]}"),
        placeholder: MemoryImage(kTransparentImage),
        fit: BoxFit.cover,
        fadeInDuration: const Duration(milliseconds: 100),
        fadeOutDuration: const Duration(milliseconds: 100),
      ),
    );
  }
}
