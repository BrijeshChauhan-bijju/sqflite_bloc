import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite_bloc/bloc/remote_database_bloc/remote_database_event.dart';
import 'package:sqflite_bloc/bloc/remote_database_bloc/remote_database_state.dart';
import 'package:sqflite_bloc/repository/remote/database_repository/database_repository.dart';

class RemoteDatabaseBloc
    extends Bloc<RemoteDatabaseEvent, RemoteDatabaseState> {
  DatabaseRepository databaseRepository;
  RemoteDatabaseBloc(
    this.databaseRepository,
  ) : super(RemoteDatabaseInitialState()) {
    on<RemoteDatabaseEvent>((event, emit) async {
      if (event is AddProductToRemoteCartEvent) {
        emit(AddProductToRemoteLoadingCart());
        var result =
            await databaseRepository.addProductToCard(event.productData!);

        if (result is bool) {
          emit(AddProductToRemoteSuccessCart(
              message: "Product added successfully"));
        } else {
          emit(AddProductToFailueCart(error: result.left));
        }
      }
    });
  }
}
