import 'package:flutter/material.dart';

import '../../l10n/wording.dart';
import '../../widgets/side_drawer.dart';
import '../../widgets/tree/file_tree.dart';

class Drawers {
  static Drawer primary(BuildContext context, NotebookCallback addNotebook) {
    return SideDrawerBuilder.build(
      context,
      FileTree(
        emptyMessage: S.of(context).noNotebooks,
        nodes: const [],
      ),
      addNotebook,
      () {},
    );
  }
}
