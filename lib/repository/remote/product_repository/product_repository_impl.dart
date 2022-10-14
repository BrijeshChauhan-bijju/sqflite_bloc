import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:sqflite_bloc/model/Product.dart';
import 'package:sqflite_bloc/repository/remote/product_repository/product_repository.dart';

class ProductRepositoryImpl extends ProductRepository {
  @override
  Future<Either<String, Product>> getProducts() async {
// products api to fetch products

    var result = await Dio().get("https://dummyjson.com/products");
    debugPrint("got result=>,${result}");
    debugPrint("got result=>,${result.statusCode}");

    if (result.statusCode == 200) {
      //return productFromJson(result.data);
      return Right(Product.fromJson(result.data));
    } else {
     return Left('Some thing went wrong');
    }
  }
}
