import 'package:flutter/material.dart';
import 'package:persian_fonts/persian_fonts.dart';
import 'package:sizer/sizer.dart';

class MainButton extends StatelessWidget {
  MainButton({required this.text, required this.clicked});

  String text;
  VoidCallback clicked;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.indigo)),
      onPressed: clicked,
      child: SizedBox(
        width: 80.w,
        height: 6.h,
        child: Center(
          child: Text(
            text,
            style: PersianFonts.Yekan.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 14.sp,
            ),
          ),
        ),
      ),
    );
  }
}
