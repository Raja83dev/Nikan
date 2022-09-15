import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persian_fonts/persian_fonts.dart';
import 'package:sizer/sizer.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        elevation: 3,
        centerTitle: true,
        title: Text(
          "profile".tr,
          style: PersianFonts.Vazir.copyWith(
              fontSize: 17.sp, fontWeight: FontWeight.w800),
        ),
      ),
    );
  }
}
