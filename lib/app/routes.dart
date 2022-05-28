import 'package:flutter/material.dart';

import '../editor/editor.dart';
import '../notes/notes.dart';
import '../viewer/viewer.dart';

class Routes {
  static const routeHome = '/';
  static const routeEditor = '/edit';
  static const routeViewer = '/view';

  static RouteFactory createRoute = (settings) {
    late Widget page;
    if (settings.name == routeHome) {
      page = const Notes();
    } else if (settings.name == routeEditor) {
      page = const Editor();
    } else if (settings.name == routeViewer) {
      page = const Viewer();
    } else {
      throw Exception('Unknown route: ${settings.name}');
    }

    return MaterialPageRoute<dynamic>(
      builder: (context) {
        return page;
      },
      settings: settings,
    );
  };
}
