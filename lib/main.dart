import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:nikan_app/languages/messags.dart';
import 'package:nikan_app/page_binding.dart';
import 'package:nikan_app/root_binding.dart';
import 'package:nikan_app/services/api_service.dart';

import 'package:sizer/sizer.dart';

void main() async {
  // await ApiService.loginWithToken();
   
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        getPages: pages,
        themeMode: ThemeMode.light,
        initialBinding: RootBinding(),
        
        initialRoute: '/login',
        translations: Messages(),
        locale: Locale('fa', 'IR'),
        //
      );
    });
  }
}
