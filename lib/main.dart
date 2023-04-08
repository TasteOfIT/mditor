import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import 'app/app.dart';
import 'app/app_module.dart';
import 'app/storage.dart';

void main() async {
  FlutterError.onError = (details) {
    Log.e(details.exceptionAsString(), stackTrace: details.stack);
  };
  WidgetsFlutterBinding.ensureInitialized();
  runZonedGuarded(() async {
    Bloc.observer = const AppBlocObserver();
    HydratedBloc.storage = await LocalStorage.createStorage();
    runApp((ModularApp(module: AppModule(), child: const MyApp())));
  }, (error, stack) {
    Log.e(error.toString(), stackTrace: stack);
  });
}
