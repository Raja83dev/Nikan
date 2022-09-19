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
      child: TextFormField(
        validator: (value) {
          if (keyboardType == TextInputType.phone) {
            if (value!.isEmpty ||
                !RegExp(r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$')
                    .hasMatch(value)) {
              //  r'^[0-9]{10}$' pattern plain match number with length 10
              return "Enter Correct Phone Number";
            } else {
              return null;
            }
          } else if (keyboardType == TextInputType.emailAddress) {
            if (value!.isEmpty ||
                !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
              return "Enter Correct Email Address";
            } else {
              return null;
            }
          } else if (keyboardType == TextInputType.name) {
            if (value!.isEmpty || !RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
              //allow upper and lower case alphabets and space
              return "Enter Correct Name";
            } else {
              return null;
            }
          } else {
            return null;
          }
        },
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
