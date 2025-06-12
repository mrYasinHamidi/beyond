import 'package:beyond/injection/app_injection.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'app.dart';
import 'core/errors/error_reporter.dart';
import 'firebase_options.dart';
import 'dart:async';

void main() => AppRunner(pipeline: errorPipeline).run();

final errorPipeline = ErrorPipeline([ConsoleReporter()]);

class AppRunner {
  final ErrorPipeline _pipeline;

  AppRunner({required ErrorPipeline pipeline}) : _pipeline = pipeline;

  Future<void> run() async {
    runZonedGuarded(
      () async {
        WidgetsFlutterBinding.ensureInitialized();

        _attachErrorHooks();

        await _initializeDependencies();

        runApp(const App());
      },
      (error, stack) {
        _pipeline.dispatch(error, stack, tag: 'zone');
      },
    );
  }

  Future<void> _initializeDependencies() async {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

    HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: kIsWeb
          ? HydratedStorageDirectory.web
          : HydratedStorageDirectory((await getTemporaryDirectory()).path),
    );

    configureDependencies();
  }

  void _attachErrorHooks() {
    FlutterError.onError = (details) {
      FlutterError.dumpErrorToConsole(details);
      _pipeline.dispatch(details.exception, details.stack ?? StackTrace.current, tag: 'flutter');
    };

    PlatformDispatcher.instance.onError = (error, stack) {
      _pipeline.dispatch(error, stack, tag: 'dispatcher');
      return true;
    };

    ErrorWidget.builder = (details) {
      const prod = bool.fromEnvironment('dart.vm.product');
      return prod ? const Center(child: Text('Something went wrong 🥲')) : ErrorWidget(details.exception);
    };
  }
}
