import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../design/theme.dart';
import '../../l10n/wording.dart';
import '../../widgets/view_dialogs.dart';
import 'drawer.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<void> _addNotebook() async {
    String name = await ViewDialogs.editorDialog(context, S.of(context).addNotebook);
    log('Input $name');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawers.primary(context, _addNotebook),
      body: _routeContainer(context),
    );
  }

  Widget _routeContainer(BuildContext context) {
    return BlocProvider(
      create: (context) => AppDrawerCubit(Scaffold.of(context)),
      child: const RouterOutlet(),
    );
  }
}
