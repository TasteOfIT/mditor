import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import 'app/app.dart';
import 'app/app_module.dart';
import 'data/storage.dart';

void main() async {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };
  WidgetsFlutterBinding.ensureInitialized();
  runZonedGuarded(() async {
    HydratedBlocOverrides.runZoned(
      () => runApp((ModularApp(module: AppModule(), child: const MyApp()))),
      blocObserver: AppBlocObserver(),
      storage: await LocalStorage.createStorage(),
    );
  }, (error, stack) {
    log(error.toString(), stackTrace: stack);
  });
}
