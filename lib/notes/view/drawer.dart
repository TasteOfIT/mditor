import 'package:flutter/material.dart';

import '../../l10n/l10n.dart';
import '../../widgets/dividers.dart';
import '../../widgets/menu.dart';
import '../../widgets/tree/file_tree.dart';

class NotesDrawer {
  static Drawer get(
    BuildContext context,
  ) {
    return Drawer(
      child: Column(
        children: [
          Menu(
            icon: Icons.my_library_books_rounded,
            label: S.of(context).notebooks,
          ),
          Dividers.horizontal(),
          Expanded(
            flex: 1,
            child: FileTree(
              emptyMessage: S.of(context).noNotebooks,
              nodes: const [],
            ),
          ),
          Dividers.horizontal(),
          Menu(
            icon: Icons.note_add_rounded,
            label: S.of(context).addNotebook,
          ),
          Dividers.horizontal(),
          Menu(
            icon: Icons.settings_applications,
            label: S.of(context).settings,
          )
        ],
      ),
    );
  }
}
