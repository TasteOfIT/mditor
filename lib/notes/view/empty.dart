import 'package:flutter/material.dart';

import '../../l10n/wording.dart';

class Empty extends StatelessWidget {
  const Empty({
    Key? key,
    this.notebookSelected = false,
  }) : super(key: key);
  final bool notebookSelected;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: _welcomeMessage(context, notebookSelected),
      ),
    );
  }

  List<Widget> _welcomeMessage(BuildContext context, bool notebookSelected) {
    if (!notebookSelected) {
      return <Widget>[
        Text(
          S.of(context).hello(S.of(context).appName),
          style: Theme.of(context).textTheme.headline2,
          textAlign: TextAlign.center,
        ),
        SizedBox.fromSize(
          size: const Size.fromHeight(20),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            S.of(context).addNotebookHint,
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
        ),
      ];
    } else {
      return <Widget>[
        Text(
          S.of(context).noNotes,
          style: Theme.of(context).textTheme.headline2,
          textAlign: TextAlign.center,
        ),
        SizedBox.fromSize(
          size: const Size.fromHeight(20),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            S.of(context).addNoteHint,
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
        ),
      ];
    }
  }
}
