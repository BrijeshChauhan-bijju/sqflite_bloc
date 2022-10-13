import 'package:sqflite_bloc/model/Product.dart';

abstract class ProductRepository {
  Future<Product> getProducts();
}
