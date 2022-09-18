import 'package:flutter/material.dart';

import '../../l10n/wording.dart';
import '../../widgets/dividers.dart';
import '../../widgets/drawer_item.dart';

class SideDrawer extends StatelessWidget {
  const SideDrawer({
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
    return Drawer(
      child: Column(
        children: [
          DrawerItem(
            icon: Icons.my_library_books_rounded,
            label: S.of(context).notebooks,
          ),
          Dividers.horizontal(),
          Expanded(
            flex: 1,
            child: fileTree,
          ),
          Dividers.horizontal(),
          DrawerItem(
            icon: Icons.note_add_rounded,
            label: S.of(context).addNotebook,
            onTap: addNotebook,
          ),
          Dividers.horizontal(),
          DrawerItem(
            icon: Icons.settings_applications,
            label: S.of(context).settings,
            onTap: openSettings,
          )
        ],
      ),
    );
  }
}

typedef NotebookCallback = VoidCallback;
typedef SettingsCallback = VoidCallback;
