import 'package:either_dart/either.dart';
import 'package:sqflite_bloc/model/Product.dart';

abstract class ProductRepository {
  Future<Either<String,Product>> getProducts();
}
