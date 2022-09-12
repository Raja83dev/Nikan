import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nikan_app/models/cart_product_model.dart';
import 'package:sizer/sizer.dart';

class ShopCartItem extends StatelessWidget {
  ShopCartItem({required this.model});

  CartProductModel model;

  @override
  Widget build(BuildContext context) {
    return Material(
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
            )
          ],
        ),
      ),
    );
  }
}
