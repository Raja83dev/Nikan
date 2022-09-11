import 'package:auto_size_text/auto_size_text.dart';

import 'package:flutter/material.dart';

import 'package:persian_fonts/persian_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:nikan_app/models/product_detail_model.dart' as model;

import '../models/product_detail_model.dart';

class CommentWidget extends StatelessWidget {
  CommentWidget({required this.commentModel});

  Comment commentModel;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 90.w,
       
          decoration: BoxDecoration(
            color: Colors.black12.withOpacity(0.08),
            borderRadius: BorderRadius.circular(4.w),
          ),
          margin: EdgeInsets.symmetric(vertical: 2.h),
          padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AutoSizeText(
                    commentModel.user!,
                    style: PersianFonts.Yekan.copyWith(
                      height: 1.5,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w800,
                      color: Colors.black45,
                    ),
                  ),
                  AutoSizeText(
                    commentModel.createdAt!,
                    style: PersianFonts.Yekan.copyWith(
                      height: 1.5,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w800,
                      color: Colors.black45,
                    ),
                  ),
                ],
              ),
            
            SizedBox(height: 1.h,),
              AutoSizeText(
                "     " + commentModel.textCm!,
                maxLines: 4,
                style: PersianFonts.Yekan.copyWith(
                  height: 1.5,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w800,
                  color: Colors.black45,
                ),
              ),
            ],
          ),
        ),
        commentModel.answer!.length > 4
            ? Container(
                width: 80.w,
                height: 10.h,
                decoration: BoxDecoration(
                  color: Colors.black12.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(4.w),
                ),
                margin: EdgeInsets.only(left: 2.w,right: 12.w),
                padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AutoSizeText(
                          "نیکان",
                          style: PersianFonts.Yekan.copyWith(
                            height: 1.5,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w800,
                            color: Colors.black45,
                          ),
                        ),
                      ],
                    ),
                    AutoSizeText(
                      "     " + commentModel.answer!,
                      maxLines: 4,
                      style: PersianFonts.Yekan.copyWith(
                        height: 1.5,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w800,
                        color: Colors.black45,
                      ),
                    ),
                  ],
                ),
              )
            : SizedBox()
      ],
    );
  }
}
