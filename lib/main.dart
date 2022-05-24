import 'package:flutter/material.dart';

import 'design/locale.dart';
import 'design/theme.dart';
import 'generated/l10n.dart';
import 'ui/edit/editor.dart';
import 'ui/home/home.dart';
import 'ui/view/viewer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateTitle: (context) => S.of(context).appName,
      localizationsDelegates: localizationDelegates,
      supportedLocales: S.delegate.supportedLocales,
      theme: lightTheme,
      darkTheme: darkTheme,
      home: const NotesList(),
      routes: {
        Editor.routeName: (context) => const Editor(),
        Viewer.routeName: (context) => const Viewer(),
      },
    );
  }
}
