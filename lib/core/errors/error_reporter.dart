import 'package:flutter/material.dart';

class ErrorPipeline {
  final List<ErrorReporter> _reporters;

  const ErrorPipeline(this._reporters);

  void dispatch(Object error, StackTrace stack, {String tag = 'unhandled'}) {
    for (final r in _reporters) {
      r.record(error, stack, tag: tag);
    }
  }
}

abstract class ErrorReporter {
  Future<void> record(Object error, StackTrace stack, {String tag = 'error'});
}

class ConsoleReporter implements ErrorReporter {
  @override
  Future<void> record(Object error, StackTrace stack, {String tag = 'console'}) async {
    debugPrint('[$tag] $error\n$stack');
  }
}

// class CrashlyticsReporter implements ErrorReporter {
//   final FirebaseCrashlytics _crashlytics;
//
//   CrashlyticsReporter(this._crashlytics);
//
//   @override
//   Future<void> record(Object error, StackTrace stack,
//       {String tag = 'crash'}) async {
//     await _crashlytics.recordError(error, stack, reason: tag);
//   }
// }
