import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:persian_fonts/persian_fonts.dart';
import 'package:nikan_app/widgets/limited_text.dart';
import 'package:sizer/sizer.dart';

class ProductButton extends StatelessWidget {
  ProductButton(
      {required this.image,
      required this.price,
      required this.name,
      required this.id});

  String image;
  String price;
  String name;
  int? id;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed('/detail', arguments: id);
      },
      child: Padding(
        padding: EdgeInsets.all(2.w),
        child: Material(
          elevation: 4,
          child: Container(
            padding: EdgeInsets.all(2.w),
            width: 40.w,
            height: 60.w,
            child: Column(
              children: [
                image.length > 7
                    ? SizedBox(
                        height: 40.w,
                        width: 40.w,
                        child: CachedNetworkImage(
                          imageUrl: image,
                          fit: BoxFit.cover,
                        ),
                      )
                    : Container(
                        child: Center(
                          child: Text(
                            "No Image",
                            style: PersianFonts.Vazir.copyWith(
                              fontSize: 17.sp,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                        height: 40.w,
                        width: 40.w,
                      ),
                Expanded(
                  child: Row(
                    children: [
                      LimitedText(
                        text: name,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.black45,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        price,
                        style: PersianFonts.Vazir.copyWith(
                          fontWeight: FontWeight.w700,
                          color: Colors.black45,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
