import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:nikan_app/constans.dart';
import 'package:nikan_app/pages/profile_page.dart';
import 'package:nikan_app/pages/search_page.dart';
import 'package:nikan_app/pages/shop_cart_page.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_switch_clipper/flutter_switch_clipper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persian_fonts/persian_fonts.dart';
import 'package:nikan_app/pages/categories_page.dart';
import 'package:nikan_app/pages/home_page.dart';
import 'package:nikan_app/widgets/limited_text.dart';
import 'package:nikan_app/widgets/product_button.dart';

import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import 'package:nikan_app/controllers/main_controller.dart';
import 'package:staggered_grid_view_flutter/staggered_grid_view_flutter.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

class MainPage extends GetView<MainController> {
  MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var pages = <Widget>[
      HomePage(),
      SearchPage(),
      CategoriesPage(),
      ProfilePage()
    ];

    return Scaffold(
      body: PersistentTabView(
        context,
        screens: pages,
        

        items: [
          PersistentBottomNavBarItem(
            activeColorPrimary: accentColor,
            inactiveColorPrimary: Colors.grey,
            icon: Icon(
              Icons.home,
            ),
          ),
          PersistentBottomNavBarItem(
            activeColorPrimary: accentColor,
            inactiveColorPrimary: Colors.grey,
            icon: Icon(
              Icons.search_outlined,
            ),
          ),
          PersistentBottomNavBarItem(
            activeColorPrimary: accentColor,
            inactiveColorPrimary: Colors.grey,
            icon: Icon(
              Icons.category_outlined,
            ),
          ),
          PersistentBottomNavBarItem(
            activeColorPrimary: accentColor,
            inactiveColorPrimary: Colors.grey,
            icon: Icon(
              Icons.person_outlined,
            ),
          ),
        ],
        onItemSelected: (value) {
          controller.selectedPageIndex.value = value;
        },
        confineInSafeArea: true,

        backgroundColor: Colors.white, // Default is Colors.white.
        handleAndroidBackButtonPress: true, // Default is true.
        resizeToAvoidBottomInset:
            true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
        stateManagement: true, // Default is true.
        hideNavigationBarWhenKeyboardShows:
            true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
        decoration: NavBarDecoration(
          boxShadow: [
            BoxShadow(
              color: accentColor.withOpacity(0.8),
              blurRadius: 3,
              offset: Offset(-1, -1),
            )
          ],
          borderRadius: BorderRadius.circular(10.0),
          colorBehindNavBar: Colors.white,
        ),
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: ItemAnimationProperties(
          // Navigation Bar's items animation properties.
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),

        screenTransitionAnimation: ScreenTransitionAnimation(
          // Screen transition animation on change of selected tab.
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        navBarStyle:
            NavBarStyle.style14,
             // Choose the nav bar style with this property.
      ),
    );
  }
}
