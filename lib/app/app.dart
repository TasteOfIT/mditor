import 'package:data/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../design/locale.dart';
import '../design/theme.dart';
import '../files/files.dart';
import '../l10n/wording.dart';
import 'app_routes.dart';

export 'app_bloc_observer.dart';
export 'app_routes.dart';
export 'log.dart';
export 'platform.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Modular.setInitialRoute(Routes.routeNotes);
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ThemeModeCubit()),
        BlocProvider(create: (_) => WorkingCubit()),
      ],
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
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<NotebookRepository>(
          create: (_) => Modular.get<NotebookRepository>(),
        ),
        RepositoryProvider<NoteRepository>(
          create: (_) => Modular.get<NoteRepository>(),
        ),
      ],
      child: MaterialApp.router(
        onGenerateTitle: (context) => S.of(context).appName,
        localizationsDelegates: localizationDelegates,
        supportedLocales: S.delegate.supportedLocales,
        themeMode: themeMode,
        theme: MditorTheme.light,
        darkTheme: MditorTheme.dark,
        routeInformationParser: Modular.routeInformationParser,
        routerDelegate: Modular.routerDelegate,
      ),
    );
  }
}
