import 'package:beyond/translation/app_translation.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class LanguageCubit extends HydratedCubit<Locale> {
  LanguageCubit() : super(AppLocalizations.supportedLocales.first);

  @override
  Locale? fromJson(Map<String, dynamic> json) => Locale(json['language_code']);

  @override
  Map<String, dynamic>? toJson(Locale state) => {'language_code': state.languageCode};
}
