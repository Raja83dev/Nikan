import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:nikan_app/controllers/shop_cart_controller.dart';
import 'package:nikan_app/widgets/main_button.dart';
import 'package:nikan_app/widgets/shop_card_item.dart';
import 'package:persian_fonts/persian_fonts.dart';
import 'package:sizer/sizer.dart';

class ShopCartPage extends GetView<ShopCartController> {
  const ShopCartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.getAllCarts();
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
      body: Stack(
        children: [
          Padding(
            padding:  EdgeInsets.only(bottom: 10.h),
            child: Center(
              child: Obx(() {
                if (controller.isloading.value == true) {
                  return SpinKitFadingGrid(color: Colors.indigo);
                }
                return SingleChildScrollView(
                  child: Column(
                    children: List.generate(controller.products.length, (index) {
                      return ShopCartItem(
                        model: controller.products[index],
                      );
                    }),
                  ),
                );
              }),
            ),
          ),
          Positioned(
            bottom: 3.h,
            left: 3.w,
            right: 3.w,
            height: 7.h,
            child: MainButton(
              text: "completing_shopping_cart".tr,
              clicked: () {},
            ),
          ),
        ],
      ),
    );
  }
}
