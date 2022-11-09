import 'package:flutter/material.dart';

import '../../l10n/wording.dart';
import '../../widgets/app_bar.dart';
import 'categories/general.dart';
import 'categories/synchronization.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SettingsState();
  }
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarBuilder.get(S.of(context).settings, []),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            General(),
            Synchronization(),
          ],
        ),
      ),
    );
  }
}
