import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:sizer/sizer.dart';

class DontHaveAccountButton extends StatelessWidget {
  DontHaveAccountButton(
      {required this.text, required this.btnText, required this.clicked});

  String text, btnText;
  VoidCallback clicked;
  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style:
                TextStyle(color: Colors.black87, fontWeight: FontWeight.w700),
          ),
          SizedBox(
            width: 1.w,
          ),
          Text(
            btnText,
            style: TextStyle(color: Colors.indigo, fontWeight: FontWeight.w700),
          ),
        ],
      ),
      onPressed: clicked,
    );
  }
}
