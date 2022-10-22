import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../l10n/wording.dart';
import '../model/file.dart';
import 'file_tree.dart';

class FileTreeItem<File> extends StatelessWidget {
  const FileTreeItem({
    Key? key,
    required this.node,
    this.optionMenu = const [],
    this.optionSelected,
  }) : super(key: key);

  final FileNode node;
  final List<MenuData> optionMenu;
  final void Function(int, File)? optionSelected;

  @override
  Widget build(BuildContext context) {
    String label = node.label;
    if (label.trim().isEmpty) {
      label = S.of(context).nameInputHint;
    }
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: Row(
        children: [
          _leadingIcon(context),
          Expanded(
            flex: 1,
            child: Text(
              node.label,
              maxLines: 1,
              style: const TextStyle(
                fontSize: 14,
                letterSpacing: 0.3,
                overflow: TextOverflow.clip,
              ),
            ),
          ),
          _trailingIcon(context),
        ],
      ),
    );
  }

  Widget _leadingIcon(BuildContext context) {
    IconData leading = Icons.sticky_note_2_rounded;
    if (node.isParent) {
      if (node.expanded) {
        leading = Icons.folder_open_rounded;
      } else {
        leading = Icons.snippet_folder_rounded;
      }
    }
    return Center(
      widthFactor: 2.0,
      child: Icon(
        leading,
        size: 20,
      ),
    );
  }

  Widget _trailingIcon(BuildContext context) {
    if (optionMenu.isNotEmpty) {
      return PopupMenuButton(
        icon: const Icon(Icons.more_vert_outlined),
        itemBuilder: (_) {
          return optionMenu.map(_buildPopupMenuItem).toList();
        },
        onSelected: (value) {
          optionSelected?.call(value as int, node.data as File);
        },
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  PopupMenuItem _buildPopupMenuItem(MenuData menu) {
    return PopupMenuItem(
      value: menu.id,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(menu.label),
        ],
      ),
    );
  }
}

class MenuData extends Equatable {
  const MenuData(this.id, this.label);

  final int id;
  final String label;

  @override
  List<Object> get props => [id, label];
}
