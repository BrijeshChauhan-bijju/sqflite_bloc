import 'package:flutter/material.dart';

abstract class LocaleEvent {}

class ChangeLocaleEvent extends LocaleEvent {
  Locale? locale;
  ChangeLocaleEvent({
    this.locale,
  });
}
