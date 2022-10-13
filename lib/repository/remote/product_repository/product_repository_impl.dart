import 'package:dio/dio.dart';
import 'package:sqflite_bloc/model/Product.dart';
import 'package:sqflite_bloc/repository/remote/product_repository/product_repository.dart';

class ProductRepositoryImpl extends ProductRepository {
  @override
  Future<Product> getProducts() async {
// products api to fetch products

    var result = await Dio().get("https://dummyjson.com/products");
    print("got result=>,${result}");

    if (result.statusCode == 200) {
      return productFromJson(result.data);
    } else {
      throw Exception('Some thing went wrong');
    }
  }
}
