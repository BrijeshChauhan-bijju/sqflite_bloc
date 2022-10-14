import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:sqflite_bloc/bloc/locale_bloc/locale_bloc.dart';
import 'package:sqflite_bloc/bloc/locale_bloc/locale_state.dart';
import 'package:sqflite_bloc/bloc/product_bloc/product_bloc.dart';
import 'package:sqflite_bloc/bloc/remote_database_bloc/remote_database_bloc.dart';
import 'package:sqflite_bloc/generated/l10n.dart';
import 'package:sqflite_bloc/repository/remote/database_repository/database_repository_impl.dart';
import 'package:sqflite_bloc/repository/remote/product_repository/product_repository_impl.dart';
import 'package:sqflite_bloc/view/product_screen.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  );
  // Pass all uncaught errors from the framework to Crashlytics.
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ProductBloc(ProductRepositoryImpl())),
        BlocProvider(create: (context) => LocaleBloc()),
        BlocProvider(create: (context) => RemoteDatabaseBloc(DatabaseRepositoryImpl())),
      ],
      child: BlocBuilder<LocaleBloc, LocaleState>(
        builder: (context, state) {
          return MaterialApp(
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: const ProductScreen(),
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            locale: state.locale,
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
