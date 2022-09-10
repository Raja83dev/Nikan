import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomizedTextField extends StatelessWidget {
  CustomizedTextField(
      {required this.hintText,
      required this.icon,
      required this.keyboardtype,
      required this.obscure,
      this.controller,
      this.suffix});

  bool obscure = false;
  TextInputType keyboardtype = TextInputType.emailAddress;
  String hintText = "Email";
  IconData icon = Icons.email;
  TextEditingController? controller;

  Widget? suffix;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardtype,
        obscureText: obscure,
        decoration: InputDecoration(
          suffixIcon: suffix,
          prefixIcon: Icon(
            icon,
            color: Colors.indigo,
          ),
          hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.black45,
            fontWeight: FontWeight.w700,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
