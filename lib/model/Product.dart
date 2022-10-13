import 'Products.dart';
import 'dart:convert';

Product productFromJson(String str) => Product.fromJson(json.decode(str));
String productToJson(Product data) => json.encode(data.toJson());
class Product {
  Product({
      this.products, 
      this.total, 
      this.skip, 
      this.limit,});

  Product.fromJson(dynamic json) {
    if (json['products'] != null) {
      products = [];
      json['products'].forEach((v) {
        products?.add(Products.fromJson(v));
      });
    }
    total = json['total'];
    skip = json['skip'];
    limit = json['limit'];
  }
  List<Products>? products;
  num? total;
  num? skip;
  num? limit;
Product copyWith({  List<Products>? products,
  num? total,
  num? skip,
  num? limit,
}) => Product(  products: products ?? this.products,
  total: total ?? this.total,
  skip: skip ?? this.skip,
  limit: limit ?? this.limit,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (products != null) {
      map['products'] = products?.map((v) => v.toJson()).toList();
    }
    map['total'] = total;
    map['skip'] = skip;
    map['limit'] = limit;
    return map;
  }

}