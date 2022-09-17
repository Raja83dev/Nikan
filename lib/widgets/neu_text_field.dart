import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class NeuTextField extends StatelessWidget {
  NeuTextField(
      {this.readOnly = false,
      required this.controller,
      required this.keyboardType,
      required this.label});

  TextEditingController controller;
  String label;
  bool readOnly = false;
  TextInputType keyboardType;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
      padding: EdgeInsets.symmetric(horizontal: 3.w),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5.w), //border corner radius
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2), //color of shadow
            spreadRadius: 1, //spread radius
            blurRadius: 7, // blur radius
            offset: Offset(0, 1),
          ),
          //you can set more BoxShadow() here
        ],
      ),
      child: TextField(
        readOnly: readOnly,
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
