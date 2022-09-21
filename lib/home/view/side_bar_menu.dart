import 'package:flutter/material.dart';

import '../../l10n/wording.dart';
import '../../widgets/dividers.dart';
import '../../widgets/icon_text_menu.dart';

class SideBarMenu extends StatelessWidget {
  const SideBarMenu({
    Key? key,
    required this.fileTree,
    required this.addNotebook,
    required this.openSettings,
  }) : super(key: key);

  final Widget fileTree;
  final NotebookCallback addNotebook;
  final SettingsCallback openSettings;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconTextMenu(
          icon: Icons.my_library_books_rounded,
          label: S.of(context).notebooks,
        ),
        Dividers.horizontal(),
        Expanded(
          flex: 1,
          child: fileTree,
        ),
        Dividers.horizontal(),
        IconTextMenu(
          icon: Icons.note_add_rounded,
          label: S.of(context).addNotebook,
          onTap: addNotebook,
        ),
        Dividers.horizontal(),
        IconTextMenu(
          icon: Icons.settings_applications,
          label: S.of(context).settings,
          onTap: openSettings,
        )
      ],
    );
  }
}

typedef NotebookCallback = VoidCallback;
typedef SettingsCallback = VoidCallback;
