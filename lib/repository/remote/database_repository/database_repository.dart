import 'package:either_dart/either.dart';
import 'package:sqflite_bloc/model/Products.dart';

abstract class DatabaseRepository{
  Future<Either<String, bool>> addProductToCard(Products products);
}