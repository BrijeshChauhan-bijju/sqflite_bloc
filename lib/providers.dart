import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/product_bloc/product_bloc.dart';
import 'repository/remote/product_repository/product_repository_impl.dart';

var providers = [
  BlocProvider(create: (context) => ProductBloc(ProductRepositoryImpl())),
];
