import 'package:flutter/material.dart';

import '../design/locale.dart';
import '../design/theme.dart';
import '../editor/editor.dart';
import '../l10n/generated/l10n.dart';
import '../notes/notes.dart';
import '../viewer/viewer.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateTitle: (context) => S.of(context).appName,
      localizationsDelegates: localizationDelegates,
      supportedLocales: S.delegate.supportedLocales,
      theme: MditorTheme.light,
      darkTheme: MditorTheme.dark,
      home: const Notes(),
      routes: {
        Editor.routeName: (context) => const Editor(),
        Viewer.routeName: (context) => const Viewer(),
      },
    );
  }
}
