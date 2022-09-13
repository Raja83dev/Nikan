import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nikan_app/models/cart_product_model.dart';
import 'package:nikan_app/pages/product_detail_page.dart';
import 'package:nikan_app/widgets/limited_text.dart';
import 'package:persian_fonts/persian_fonts.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:sizer/sizer.dart';

class ShopCartItem extends StatelessWidget {
  ShopCartItem({required this.model});

  CartProductModel model;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(ProductDetailPage(),arguments: model.id);
      },
      child: Material(
        child: Container(
          width: 90.w,
          height: 20.h,
          margin: EdgeInsets.symmetric(vertical: 1.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3.w),
          ),
          child: Row(
            children: [
              Container(
                height: 20.h,
                width: 20.h,
                margin: EdgeInsets.all(1.w),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(model.image!),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    AutoSizeText(
                      model.title!,
                      maxLines: 2,
                      style: PersianFonts.Yekan.copyWith(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.black54,
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          AutoSizeText(
                            model.price!.seRagham(),
                            textAlign: TextAlign.end,
                            maxLines: 2,
                            style: PersianFonts.Yekan.copyWith(
                              decoration: TextDecoration.lineThrough,
                              decorationThickness: 2,
                              fontSize: 9.sp,
                              fontWeight: FontWeight.w700,
                              color: Colors.red[600],
                            ),
                          ),
                          SizedBox(
                            width: 2.w,
                          ),
                          AutoSizeText(
                            model.price!.seRagham(),
                            textAlign: TextAlign.end,
                            maxLines: 2,
                            style: PersianFonts.Yekan.copyWith(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w900,
                              color: Colors.green[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
