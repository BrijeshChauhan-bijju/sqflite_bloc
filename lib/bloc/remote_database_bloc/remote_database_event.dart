import 'package:sqflite_bloc/model/Products.dart';

abstract class RemoteDatabaseEvent {
  RemoteDatabaseEvent();
}

class AddProductToRemoteCartEvent extends RemoteDatabaseEvent {
  Products productData;
  AddProductToRemoteCartEvent(this.productData);
}
