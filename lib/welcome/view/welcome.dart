import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../app/app.dart';
import '../../design/theme.dart';
import '../../l10n/wording.dart';
import '../../widgets/app_bar.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  void _newNote() {
    Routes.open(Routes.routeEditor);
  }

  void _openDrawer() {
    context.read<AppDrawerCubit>().openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarBuilder.withDrawer(
        context,
        S.of(context).home,
        _openDrawer,
        const [],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              S.of(context).hello(S.of(context).appName),
              style: Theme.of(context).textTheme.headline2,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _newNote,
        tooltip: S.of(context).add,
        child: const Icon(Icons.add),
      ),
    );
  }
}
