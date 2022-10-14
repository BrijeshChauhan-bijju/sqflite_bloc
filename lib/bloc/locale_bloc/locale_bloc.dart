import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite_bloc/bloc/locale_bloc/locale_event.dart';
import 'package:sqflite_bloc/bloc/locale_bloc/locale_state.dart';

class LocaleBloc extends Bloc<LocaleEvent, LocaleState> {
  LocaleBloc()
      : super(LocaleState(
          locale: const Locale('en'),
        )) {
    on<LocaleEvent>((event, emit) {
      if (event is ChangeLocaleEvent) {
        emit(LocaleState(locale: event.locale));
      }
    });
  }
}
