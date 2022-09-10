import 'package:flutter/material.dart';
import 'package:persian_fonts/persian_fonts.dart';
import 'package:sizer/sizer.dart';

class LimitedText extends StatelessWidget {
  LimitedText({required this.text, required this.fontSize, this.fontWeight,this.color});

  String text;
  double fontSize;
  FontWeight? fontWeight = FontWeight.w700;

  Color? color = Colors.white;
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: RichText(
        overflow: TextOverflow.ellipsis,
        strutStyle: StrutStyle(fontSize: 10.sp),
        text: TextSpan(
            style: PersianFonts.Yekan.copyWith(
              color: color,
              fontWeight: fontWeight,
              fontSize: fontSize,
            ),
            text: text),
      ),
    );
  }
}
