import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class MessageItem extends StatelessWidget {
  MessageItem({required this.text, this.isMe = true});

  String text;
  bool isMe = true;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100.w,
      child: Align(
        alignment: isMe ? Alignment.centerLeft : Alignment.centerRight,
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 1.h),
          padding: EdgeInsets.symmetric(
            horizontal: 3.w,
            vertical: 1.5.h,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2.w),
            color: Colors.grey.withOpacity(0.2),
          ),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w800,
              color: Colors.black45,
            ),
          ),
        ),
      ),
    );
  }
}
