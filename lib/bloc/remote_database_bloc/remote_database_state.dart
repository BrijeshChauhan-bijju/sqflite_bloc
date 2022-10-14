abstract class RemoteDatabaseState {
  RemoteDatabaseState();
}

class RemoteDatabaseInitialState extends RemoteDatabaseState {
  List<Object?> get props => [];
}

class AddProductToRemoteSuccessCart extends RemoteDatabaseState {
  String? message;
  AddProductToRemoteSuccessCart({
    this.message,
  });
}

class AddProductToRemoteLoadingCart extends RemoteDatabaseState {}

class AddProductToFailueCart extends RemoteDatabaseState {
  String? error;
  AddProductToFailueCart({
    this.error,
  });
}
