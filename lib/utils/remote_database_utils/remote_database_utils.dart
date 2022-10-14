import 'dart:async';
import 'package:either_dart/either.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:sqflite_bloc/model/Products.dart';

class RemoteProductDao {
  final databaseReference = FirebaseDatabase.instance.ref();

  //Adds new Product records
  Future<Either<String, bool>> addProductToCart(Products data) async {
    try {
   await databaseReference.child(data.id.toString()).set(
          data.toJson());
    return const Right(true);
    }catch(e){
      return const Left('some thing went wrong');
    }
  }
}
