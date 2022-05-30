import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../design/locale.dart';
import '../design/theme.dart';
import '../l10n/wording.dart';
import 'routes.dart';

export 'app_bloc_observer.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ThemeModeCubit(),
      child: BlocBuilder<ThemeModeCubit, ThemeMode>(builder: (context, themeMode) {
        return AppView(themeMode: themeMode);
      }),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({Key? key, this.themeMode = ThemeMode.system}) : super(key: key);

  final ThemeMode themeMode;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateTitle: (context) => S.of(context).appName,
      localizationsDelegates: localizationDelegates,
      supportedLocales: S.delegate.supportedLocales,
      themeMode: themeMode,
      theme: MditorTheme.light,
      darkTheme: MditorTheme.dark,
      onGenerateRoute: (settings) => Routes.createRoute(settings),
    );
  }
}
