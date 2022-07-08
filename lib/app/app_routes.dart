import 'package:flutter_modular/flutter_modular.dart';

import '../editor/editor.dart';
import '../notes/notes.dart';
import '../viewer/viewer.dart';

class Routes {
  static const routeHome = '/';
  static const routeEditor = '/edit';
  static const routeViewer = '/view';

  static List<ModularRoute> get() {
    return [
      ChildRoute(routeHome, child: (context, args) => const Notes()),
      ChildRoute(routeEditor, child: (context, args) => const Editor()),
      ChildRoute(routeViewer, child: (context, args) => const Viewer()),
    ];
  }
}
