import 'package:get/get.dart';
import 'package:nikan_app/pages/forgot_password_page.dart';
import 'package:nikan_app/pages/login_page.dart';
import 'package:nikan_app/pages/main_page.dart';
import 'package:nikan_app/pages/product_detail_page.dart';
import 'package:nikan_app/pages/search_page.dart';

import 'package:nikan_app/pages/signup_page.dart';
import 'package:nikan_app/pages/vertification_code_page.dart';

var pages = <GetPage>[
  GetPage(
    name: '/login',
    page: () => LoginPage(),
  ),
  GetPage(
    name: '/signup',
    page: () => SignUpPage(),
  ),
  GetPage(
    name: '/verify_code',
    page: () => VertificationCodePage(),
  ),
  GetPage(
    name: '/forgot_password',
    page: () => ForgotPasswordPage(),
  ),
  GetPage(
    name: '/main',
    page: () => MainPage(),
  ),
  GetPage(
    name: '/search',
    page: () => SearchPage(),
  ),
  GetPage(
    name: '/detail',
    page: () => ProductDetailPage(),
  ),
];
