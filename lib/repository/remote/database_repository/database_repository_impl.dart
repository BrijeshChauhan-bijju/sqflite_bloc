import 'package:either_dart/either.dart';
import 'package:sqflite_bloc/model/Products.dart';
import 'package:sqflite_bloc/repository/remote/database_repository/database_repository.dart';
import 'package:sqflite_bloc/utils/remote_database_utils/remote_database_utils.dart';

class DatabaseRepositoryImpl extends DatabaseRepository {
  RemoteProductDao remoteProductDao = RemoteProductDao();

  @override
  Future<Either<String, bool>> addProductToCard(Products products) {
   var result =  remoteProductDao.addProductToCart(products);
   return result;
  }
}
