import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:nikan_app/models/product_detail_model.dart';
import 'package:nikan_app/models/product_model.dart';
import 'package:nikan_app/models/products_model.dart';
import 'package:nikan_app/models/slider_image_model.dart';
import 'package:nikan_app/models/tag_model.dart';

import 'package:shared_preferences/shared_preferences.dart';

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
        showSnake("خطا", data['message']);
        return false;
      } else {
        print("Show : ${data['token']}");
        var prefs = await SharedPreferences.getInstance();
        prefs.setString("APP_TOKEN", data['token']);
        showSnake("انجام شد", data['message']);
        return true;
      }
    }
    showSnake("خطا", "اتصال اینترنت برقرار نیست");
    return false;
  }

  static Future<bool> signup(String phone) async {
    var req = await http.post(Uri.parse(baseUrl + "register"), body: {
      "phone": phone,
    });

    print("STATUS -: ${req.statusCode}");

    if (req.statusCode == 200) {
      var data = jsonDecode(req.body);
      if (data['status'].toString() == 100.toString()) {
        showSnake("خطا", data['message']);
        return false;
      } else {
        print("Show : ${data['token']}");

        var prefs = await SharedPreferences.getInstance();
        prefs.setString("APP_TOKEN", data['token']);
        return true;
      }
    }
    showSnake("خطا", "اتصال اینترنت برقرار نیست");
    return false;
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
      showSnake("خطا", "اتصال اینترنت برقرار نیست");
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
      showSnake("خطا", "اتصال اینترنت برقرار نیست");
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
  }

  static Future<bool> activeCode(String code) async {
    var prefs = await SharedPreferences.getInstance();
    print("TOKEN : ${prefs.getString("APP_TOKEN")}");
    var req = await http.post(
        Uri.parse(baseUrl + "code?${prefs.getString("APP_TOKEN")}&$code"));
    print("Status Code : " + req.statusCode.toString());
    return req.statusCode == 200;
  }

  static Future<bool> loginWithToken() async {
    var prefs = await SharedPreferences.getInstance();
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
      var data = jsonDecode(req.body);

      return true;
    }
    print(req.statusCode);
    return false;
  }
}

void showSnake(String title, String message) {
  Get.snackbar(
    title,
    message,
    backgroundColor: Colors.indigoAccent,
    colorText: Colors.white,
    snackPosition: SnackPosition.BOTTOM,
  );
}
