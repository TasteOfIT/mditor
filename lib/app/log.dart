import 'dart:developer';

import 'package:flutter/foundation.dart' show kReleaseMode;

class Log {
  static d(String message) {
    if (!kReleaseMode) log(message);
  }

  static e(String message, {Object? error, StackTrace? stackTrace}) {
    log(message, error: error, stackTrace: stackTrace);
  }
}
