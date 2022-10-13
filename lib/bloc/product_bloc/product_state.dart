import 'package:flutter/cupertino.dart';
import 'package:sqflite_bloc/model/Product.dart';

abstract class ProductState {
  Product? product;
}

class GetProductInitialState extends ProductState {}

class GetProductLoadingState extends ProductState {}

class GetProductSuccessState extends ProductState {
  Product? product;

  GetProductSuccessState({
    this.product,
  });

  List<Object?> get props => [product];
}

class GetProductFailureState extends ProductState {
  String? error;

  GetProductFailureState({
    this.error,
  });
}
