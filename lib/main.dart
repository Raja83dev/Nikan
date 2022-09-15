import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:nikan_app/languages/messags.dart';
import 'package:nikan_app/pages/login_page.dart';
import 'package:nikan_app/pages/main_page.dart';
import 'package:nikan_app/pages/shop_cart_page.dart';
import 'package:nikan_app/pages/splash_page.dart';
import 'package:nikan_app/root_binding.dart';
import 'package:nikan_app/services/api_service.dart';

import 'package:sizer/sizer.dart';

void main() async {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.light,
        initialBinding: RootBinding(),
        translations: Messages(),
        locale: Locale('fa', 'IR'),
        home: SplashScreen(),
      );
    });
  }
}
