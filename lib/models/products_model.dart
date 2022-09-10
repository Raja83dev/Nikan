// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:nikan_app/models/product_model.dart';

class ProductsModel {
  int? id;
  String? name;
  List<Product>? product;

  ProductsModel({this.id, this.name, this.product});

  ProductsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    if (json['product'] != null) {
      product = <Product>[];
      json['product'].forEach((v) {
        product!.add(new Product.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.product != null) {
      data['product'] = this.product!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

