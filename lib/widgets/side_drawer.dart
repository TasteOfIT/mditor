import 'package:flutter/material.dart';

import '../l10n/wording.dart';
import '../widgets/dividers.dart';
import '../widgets/drawer_item.dart';
import 'tree/file_tree.dart';

class SideDrawerBuilder {
  static Drawer build(
    BuildContext context,
    FileTree files,
    NotebookCallback addNotebook,
    SettingsCallback openSettings,
  ) {
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
            child: files,
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
