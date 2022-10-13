import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite_bloc/bloc/product_bloc/product_event.dart';
import 'package:sqflite_bloc/bloc/product_bloc/product_state.dart';
import 'package:sqflite_bloc/repository/remote/product_repository/product_repository.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductRepository productRepository;

  ProductBloc(this.productRepository) : super(GetProductInitialState()) {
    on<GetProductEvent>((event, emit) async {
      emit(GetProductLoadingState());
      try {
        var result = await productRepository.getProducts();
        emit(GetProductSuccessState(product: result));
      }on Exception  {
        emit(GetProductFailureState(error: 'some thing went wrong'));
      }
    });
  }
}
