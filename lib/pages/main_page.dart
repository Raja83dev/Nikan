import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
import 'package:nikan_app/widgets/banner_button.dart';
import 'package:nikan_app/widgets/limited_text.dart';
import 'package:nikan_app/widgets/product_button.dart';
import 'package:nikan_app/widgets/tag_button.dart';
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
    var pages = <Widget>[HomePage(), CategoriesPage(), Container(), Container()];
    return Obx(() {
      return Scaffold(
        body: pages[controller.selectedPageIndex.value],
        bottomNavigationBar: AnimatedBottomNavigationBar(
          icons: [
            Icons.search_outlined,
            Icons.category_outlined,
            Icons.sell_outlined,
            Icons.person_outlined
          ],

          activeColor: Colors.indigo,
          blurEffect: true,
          splashRadius: 5.h,
          splashColor: Colors.indigo,
          activeIndex: controller.selectedPageIndex.value,
          gapWidth: 0,
          onTap: (index) {
            controller.selectedPageIndex.value = index;
          },
          //other params
        ),
      );
    });
  }

 
  
}
