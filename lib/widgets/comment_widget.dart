import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CommentWidget extends StatelessWidget {
  const CommentWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90.w,
      height: 15.h,
      margin: EdgeInsets.symmetric(vertical: 1.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(5.w),
          topRight: Radius.circular(5.w),
          bottomLeft: Radius.circular(5.w),
          bottomRight: Radius.circular(5.w),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5), //shadow color
            spreadRadius: 5, // spread radius
            blurRadius: 7, // shadow blur radius
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
    );
  }
}
