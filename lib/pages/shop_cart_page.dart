import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:nikan_app/controllers/shop_cart_controller.dart';
import 'package:persian_fonts/persian_fonts.dart';
import 'package:sizer/sizer.dart';

class ShopCatPage extends GetView<ShopCartController> {
  const ShopCatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo[400],
        centerTitle: true,
        title: Text(
          "cart".tr,
          style: PersianFonts.Yekan.copyWith(
            fontSize: 17.sp,
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
        ),
      ),
      body: Obx(() {
        if (controller.isloading.value == true) {
          return Center(
            child: SpinKitFadingGrid(color: Colors.indigo),
          );
        }
        return Column(
          children: [
            
          ],
        );
      }),
    );
  }
}
