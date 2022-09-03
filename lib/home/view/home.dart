import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../design/theme.dart';
import 'drawer.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawers.primary(context),
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
