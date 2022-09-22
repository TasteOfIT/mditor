import 'package:data/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../app/app.dart';
import '../../l10n/wording.dart';
import '../../widgets/dividers.dart';
import '../../widgets/icon_text_menu.dart';
import '../../widgets/view_dialogs.dart';

class SideBarMenu extends StatefulWidget {
  const SideBarMenu({
    Key? key,
    required this.fileTree,
  }) : super(key: key);

  final Widget fileTree;

  @override
  State<StatefulWidget> createState() {
    return _SideBarMenuState();
  }
}

class _SideBarMenuState extends State<SideBarMenu> {
  late NotebookRepository _notebookRepository;

  @override
  void initState() {
    super.initState();
    _notebookRepository = RepositoryProvider.of<NotebookRepository>(context);
  }

  Future<void> _addNotebook() async {
    String name = await ViewDialogs.editorDialog(context, S.of(context).addNotebook);
    if (name.trim().isNotEmpty) {
      int result = await _notebookRepository.addNotebook(name.trim());
      Log.d('Insert $result');
    }
  }

  void _openSettings() {}

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
          child: widget.fileTree,
        ),
        Dividers.horizontal(),
        IconTextMenu(
          icon: Icons.note_add_rounded,
          label: S.of(context).addNotebook,
          onTap: _addNotebook,
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
