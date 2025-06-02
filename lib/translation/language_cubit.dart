import 'package:beyond/translation/app_translation.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';

@singleton
class LanguageCubit extends HydratedCubit<Locale> {
  LanguageCubit() : super(AppLocalizations.supportedLocales.first);

  changeLanguage() {
    final newState = AppLocalizations.supportedLocales.firstWhere((element) => element != state);
    emit(newState);
  }

  @override
  Locale? fromJson(Map<String, dynamic> json) => Locale(json['language_code']);

  @override
  Map<String, dynamic>? toJson(Locale state) => {'language_code': state.languageCode};

  @disposeMethod
  @override
  Future<void> close() {
    return super.close();
  }
}
