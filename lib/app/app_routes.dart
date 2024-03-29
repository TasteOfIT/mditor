import 'package:flutter_modular/flutter_modular.dart';

import '../editor/editor.dart';
import '../files/view/folder_picker.dart';
import '../notes/notes.dart';
import '../settings/settings.dart';
import '../viewer/viewer.dart';

class Routes {
  static const routeNotes = '/';
  static const routeEditor = '/edit';
  static const routeViewer = '/view';
  static const routePicker = '/pick';
  static const routeSettings = '/settings';

  static List<ModularRoute> get() {
    return [
      ChildRoute(routeNotes, child: (context, args) => Notes(notebookId: args.data as String?)),
      ChildRoute(routeEditor, child: (context, args) => Editor(noteId: args.data as String)),
      ChildRoute(routeViewer, child: (context, args) => Viewer(noteId: args.data as String)),
      ChildRoute(routePicker, child: (context, args) => FolderPicker(id: args.data as String)),
      ChildRoute(routeSettings, child: (context, args) => const Settings()),
    ];
  }

  static Future<dynamic> add(String path, {dynamic args}) {
    return Modular.to.pushNamed(path, arguments: args);
  }

  static void open(String path, {dynamic args}) {
    Modular.to.navigate(path, arguments: args);
  }

  static void pop({dynamic result}) {
    Modular.to.pop(result);
  }

  static dynamic getPathParam(String key) {
    return Modular.args.params[key];
  }

  static dynamic getQueryParam(String key) {
    return Modular.args.queryParams[key];
  }

  static dynamic getData() {
    return Modular.args.data;
  }

  static int historyNumber() {
    return Modular.to.navigateHistory.length;
  }

  static String? current() {
    var history = Modular.to.navigateHistory;
    if (history.isEmpty) {
      return '';
    } else {
      return history.last.name;
    }
  }
}
