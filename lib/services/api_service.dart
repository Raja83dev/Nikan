import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:nikan_app/constans.dart';
import 'package:nikan_app/models/cart_product_model.dart';
import 'package:nikan_app/models/city_model.dart';
import 'package:nikan_app/models/product_detail_model.dart';
import 'package:nikan_app/models/product_model.dart';
import 'package:nikan_app/models/products_model.dart';
import 'package:nikan_app/models/save_product_model.dart';
import 'package:nikan_app/models/slider_image_model.dart';
import 'package:nikan_app/models/state_model.dart';
import 'package:nikan_app/models/sub_category_model.dart';
import 'package:nikan_app/models/tag_model.dart';
import 'package:nikan_app/models/user_model.dart';
import 'package:nikan_app/pages/splash_page.dart';
import 'package:persian_fonts/persian_fonts.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

const baseUrl = "https://nikan.info/api/v1/";

class ApiService {
  static Future<bool> login(String phone, String pass) async {
    var req = await http.post(Uri.parse(baseUrl + "login"), body: {
      "phone": phone,
      "password": pass,
    });

    if (req.statusCode == 200) {
      var data = jsonDecode(req.body);
      if (data['status'].toString() == 100.toString()) {
        showSnake(data['message']);
        return false;
      } else {
        print("Show : ${data['token']}");
        var prefs = await SharedPreferences.getInstance();
        prefs.setString("APP_TOKEN", data['token']);

        return true;
      }
    }
    showSnake("اتصال اینترنت برقرار نیست");
    return false;
  }

  static Future<String> signup(String phone) async {
    var req = await http.post(Uri.parse(baseUrl + "register"), body: {
      "phone": phone,
    });

    print("STATUS -: ${req.statusCode}");

    if (req.statusCode == 200) {
      var data = jsonDecode(req.body);
      if (data['status'].toString() == 100.toString()) {
        showSnake(data['message']);
        return "";
      } else {
        print("Show : ${data['token']}");

        return data['token'];
      }
    }
    showSnake("اتصال اینترنت برقرار نیست");
    return "";
  }

  static Future<List<SliderImageModel>> getSliderImages() async {
    var req = await http.get(Uri.parse(baseUrl + "slider"));

    if (req.statusCode == 200) {
      List<SliderImageModel> list = <SliderImageModel>[];
      var data = jsonDecode(req.body);

      for (var item in data) {
        list.add(
          SliderImageModel(
            image: item['image'],
            url: item['url'],
          ),
        );
      }
      return list;
    } else {
      showSnake("اتصال اینترنت برقرار نیست");
      throw Exception();
    }
  }

  static Future<List<TagModel>> getCategories() async {
    var req = await http.get(Uri.parse(baseUrl + "category/list"));

    if (req.statusCode == 200) {
      List<TagModel> list = <TagModel>[];
      var data = jsonDecode(req.body);

      for (var item in data) {
        list.add(
          TagModel(
            image: item['image'],
            name: item['name'],
            id: item['id'],
          ),
        );
      }
      return list;
    } else {
      showSnake("اتصال اینترنت برقرار نیست");
      throw Exception();
    }
  }

  static Future<List<ProductsModel>> productList() async {
    var req = await http.get(Uri.parse(baseUrl + "home/product"));

    List<ProductsModel> products = <ProductsModel>[];
    if (req.statusCode == 200) {
      for (var item in jsonDecode(req.body)) {
        List<Product> product = <Product>[];
        for (var item2 in item['product']) {
          product.add(Product(
              id: item2['id'],
              image: item2['image'],
              price: item2['price'],
              title: item2['title']));
        }

        products.add(ProductsModel(
            id: item['id'], name: item['name'], product: product));
      }
    }

    return products;
  }

  static Future<List<Product>> searchProducts(String search) async {
    var req = await http.get(Uri.parse(baseUrl + "search?title=" + search));

    List<Product> product = <Product>[];
    if (req.statusCode == 200) {
      for (var item in jsonDecode(req.body)) {
        product.add(Product(
            id: item['id'],
            title: item['title'],
            image: item['image'],
            price: item['price']));
      }
    }

    return product;
  }

  static Future<ProductDetail?> productdetail(int id) async {
    var prefs = await SharedPreferences.getInstance();
    print("id : " + id.toString());
    var req = await http.get(Uri.parse(
      baseUrl +
          "product/details/${id.toString()}?token=${prefs.getString("APP_TOKEN")}",
    ));

    if (req.statusCode == 200) {
      var detail = ProductDetail.fromJson(jsonDecode(req.body));
      print("Status OK");
      return (detail);
    }
    return null;
  }

  static Future<void> sendPasstoPhoneNumber(String phone) async {
    var req = await http.get(Uri.parse(
      baseUrl + "forget/password?phone=" + phone.toString(),
    ));
    var data = jsonDecode(req.body);
    if (data['status'].toString() == 100.toString()) {
      showSnake(data['message'].toString());
    }
  }

  static Future<bool> activeCode(String code, String token) async {
    print("TOKEN : $token");
    var req = await http.post(
      Uri.parse(baseUrl + "code"),
      body: {"token": token, "sms": code},
    );

    var data = jsonDecode(req.body);
    showSnake(data['message']);
    return req.statusCode == int.parse((data['status']).toString());
  }

  static Future<bool> loginWithToken() async {
    var prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey("APP_TOKEN")) {
      return false;
    }

    print("TOKEN : ${prefs.getString("APP_TOKEN")}");
    var req = await http.get(
        Uri.parse(baseUrl + "token/check/${prefs.getString("APP_TOKEN")}"));

    return req.statusCode == 200;
  }

  static Future<bool> addToCart(String id) async {
    var prefs = await SharedPreferences.getInstance();

    var req = await http.get(Uri.parse(
        baseUrl + "add/to/cart/$id?token=${prefs.getString("APP_TOKEN")}"));

    if (req.statusCode == 200) {
      var data = jsonDecode(req.body);

      return true;
    }
    return false;
  }

  static Future<bool> removeFromCart(String id) async {
    var prefs = await SharedPreferences.getInstance();

    var req = await http.get(Uri.parse(
        baseUrl + "remove/cart/$id?token=${prefs.getString("APP_TOKEN")}"));

    if (req.statusCode == 200) {
      print("Deleted");
      var data = jsonDecode(req.body);

      return true;
    }
    print(req.statusCode);
    return false;
  }

  static Future<List<CartProductModel>> cartList() async {
    var prefs = await SharedPreferences.getInstance();
    var req = await http.get(
        Uri.parse(baseUrl + "cart/list?token=${prefs.getString("APP_TOKEN")}"));

    List<CartProductModel> products = <CartProductModel>[];
    if (req.statusCode == 200) {
      for (var item in jsonDecode(req.body)) {
        products.add(CartProductModel.fromJson(item));
      }
    }
    print("Cart Length : ${products.length}");
    return products;
  }

  static Future<SubCategoryModel?> getSubCategory(int id) async {
    var req = await http.get(Uri.parse(baseUrl + "subcategory/list/$id"));

    if (req.statusCode == 200) {
      var detail = SubCategoryModel.fromJson(jsonDecode(req.body));
      print("Status OK");
      return (detail);
    } else {
      return null;
    }
  }

  static Future<UserModel> getUserDatas() async {
    var prefs = await SharedPreferences.getInstance();
    var req = await http.get(
        Uri.parse(baseUrl + "edit/profile/${prefs.getString("APP_TOKEN")}"));

    var data = jsonDecode(req.body);
    return UserModel(
      avatar: data['avatar'].toString(),
      born: data['born'].toString(),
      city: data['city'].toString(),
      email: data['email'].toString(),
      fullName: data['full_name'].toString(),
      idNumber: data['id_number'].toString(),
      job: data['job'].toString(),
      phone: data['phone'].toString(),
      state: data['state'].toString(),
    );
  }

  static Future<void> saveUserData(UserModel model) async {
    var prefs = await SharedPreferences.getInstance();
    var request = http.MultipartRequest("POST",
        Uri.parse(baseUrl + "update/profile/${prefs.getString("APP_TOKEN")}"));

    if (model.avatar! != "") {
      print("Image Req Added");
      request.files
          .add(await http.MultipartFile.fromPath('avatar', model.avatar!));
    }
    request.fields['full_name'] = model.fullName!;
    request.fields['phone'] = model.phone!;
    request.fields['email'] = model.email!;
    request.fields['id_number'] = model.idNumber!;
    request.fields['born'] = model.born!;
    request.fields['job'] = model.job!;
    if (model.state == "100000" || model.state == "") {
    } else {
      request.fields['state'] = model.state!;
    }
    if (model.city == "100000" || model.city == "") {
    } else {
      request.fields['city'] = model.city!;
    }

    var response = await request.send();

    print("Status Code For Update Profile ${response.statusCode}");
  }

  static Future<void> saveProduct(String id) async {
    var prefs = await SharedPreferences.getInstance();
    var req = await http.get(Uri.parse(
        baseUrl + "save/product/$id?token=${prefs.getString("APP_TOKEN")}"));
    if (jsonDecode(req.body)['status'].toString() == "200") {
      print("Saved");
    }
  }

  static Future<void> removeSaveProduct(String id) async {
    var prefs = await SharedPreferences.getInstance();
    var req = await http.get(Uri.parse(baseUrl +
        "remove/save/product/$id?token=${prefs.getString("APP_TOKEN")}"));
    if (jsonDecode(req.body)['status'].toString() == "200") {
      print("Saved");
    }
  }

  static Future<List<SaveProductModel>> productSaveList() async {
    var prefs = await SharedPreferences.getInstance();
    var req = await http.get(Uri.parse(
        baseUrl + "list/save/product/${prefs.getString("APP_TOKEN")}"));

    if (req.body.toString().contains("100")) {
      return <SaveProductModel>[];
    }

    var data = jsonDecode(req.body);
    var list = <SaveProductModel>[];
    for (var item in data) {
      list.add(
        SaveProductModel(
          id: item['id'],
          image: item['image'],
          title: item['title'],
        ),
      );
    }
    return list;
  }

  static Future<List<CartProductModel>> getArchive(String id) async {
    var req = await http.get(Uri.parse(baseUrl + "sub/category/archive/$id"));

    List<CartProductModel> products = <CartProductModel>[];
    if (req.statusCode == 200) {
      if (req.body.toString() == "100") {
        print("No Data");
        return <CartProductModel>[];
      }

      for (var item in jsonDecode(req.body)) {
        products.add(CartProductModel(
            delPrice: item['del_price'].toString(),
            id: item['id'].toString(),
            image: item['image'].toString(),
            price: item['price'].toString(),
            title: item['title']));
      }
    }
    print("Status Code : ${req.statusCode}");

    print("Archive Length : ${products.length}");
    return products;
  }

  static void logOut() async {
    var prefs = await SharedPreferences.getInstance();
    prefs.remove("APP_TOKEN");
    Get.offAll(SplashScreen());
  }

  static Future<List<StateModel>> getStates() async {
    var req = await http.get(Uri.parse(baseUrl + "state"));

    var list = <StateModel>[];
    if (req.statusCode == 200) {
      var datas = jsonDecode(req.body);
      for (var item in datas) {
        list.add(StateModel(item['id'], item['title']));
      }
    }
    return list;
  }

  static Future<List<CityModel>> getCities() async {
    var req = await http.get(Uri.parse(baseUrl + "city"));

    var list = <CityModel>[];
    if (req.statusCode == 200) {
      var datas = jsonDecode(req.body);
      for (var item in datas) {
        list.add(CityModel(item['id'], item['title'], item['state_id']));
      }
    }
    return list;
  }
}

void showSnake(String message) {
  // Get.snackbar(
  //   title,
  //   message,
  //   backgroundColor: accentColor,
  //   colorText: Colors.white,
  //   snackPosition: SnackPosition.BOTTOM,
  // );
  Get.showSnackbar(
    GetSnackBar(
      animationDuration: Duration(seconds: 1),
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
      margin: EdgeInsets.symmetric(vertical: 3.h, horizontal: 4.w),
      borderColor: accentColor.withOpacity(0.5),
      borderRadius: 6.w,
      barBlur: 10,
      titleText: Row(
        children: [
          Icon(
            Icons.error,
            color: Colors.red,
          ),
          SizedBox(
            width: 2.w,
          ),
          Text(
            message,
            style: PersianFonts.Vazir.copyWith(
              fontSize: 15.sp,
              color: accentColor,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
      messageText: SizedBox(),
      backgroundColor: Colors.white,
      snackPosition: SnackPosition.TOP,
    ),
  );
}
