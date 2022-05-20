import 'package:flutter/material.dart';

import 'design/locale.dart';
import 'design/theme.dart';
import 'generated/l10n.dart';
import 'home/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateTitle: (context) => S.of(context).appName,
      localizationsDelegates: localizationDelegates,
      supportedLocales: S.delegate.supportedLocales,
      theme: lightTheme,
      darkTheme: darkTheme,
      home: MyHomePage(onGenerateTitle: (context) => S.of(context).home),
    );
  }
}
