import 'package:beyond/translation/app_translation.dart';
import 'package:flutter/material.dart';

extension TranslatorExtension on BuildContext {
  AppLocalizations get translator => Localizations.of<AppLocalizations>(this, AppLocalizations)!;
}
