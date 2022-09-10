import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class HelperButton extends StatelessWidget {
  const HelperButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 90.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Best Rating",
            style: TextStyle(
              fontSize: 17.sp,
              fontWeight: FontWeight.w800,
              color: Colors.black54,
            ),
          ),
          CupertinoButton(
            child: Text(
              "See All",
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black45,
              ),
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
