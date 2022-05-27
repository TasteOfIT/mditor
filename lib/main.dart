import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'app/app.dart';
import 'app/app_bloc_observer.dart';

void main() {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };
  runZonedGuarded(() {
    BlocOverrides.runZoned(
      () => runApp(const MyApp()),
      blocObserver: AppBlocObserver(),
    );
  }, (error, stack) {
    log(error.toString(), stackTrace: stack);
  });
}
