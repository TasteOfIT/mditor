import 'package:flutter/material.dart';

import '../../l10n/wording.dart';
import '../../widgets/dividers.dart';
import '../../widgets/icon_text_menu.dart';

class SideBarMenu extends StatelessWidget {
  const SideBarMenu({
    Key? key,
    required this.fileTree,
  }) : super(key: key);

  final Widget fileTree;

  void _openSettings() {}

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 1,
          child: fileTree,
        ),
        Dividers.horizontal(),
        IconTextMenu(
          icon: Icons.settings_applications,
          label: S.of(context).settings,
          onTap: _openSettings,
        )
      ],
    );
  }
}
