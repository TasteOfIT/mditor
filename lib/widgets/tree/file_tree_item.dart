import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'file.dart';
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
    return Padding(
      padding: const EdgeInsets.only(left: 6, right: 12),
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
    IconData leading = Icons.lightbulb_circle_rounded;
    if (node.isParent) {
      if (node.expanded) {
        leading = Icons.arrow_circle_up_rounded;
      } else {
        leading = Icons.arrow_circle_down_rounded;
      }
    }
    return Center(
        widthFactor: 2.0,
        child: Padding(
          padding: EdgeInsets.only(left: node.isParent ? 0 : 1), // Workaround for flutter_treeview to align icons
          child: Icon(
            leading,
            size: 20,
          ),
        ));
  }

  Widget _trailingIcon(BuildContext context) {
    return PopupMenuButton(
      icon: const Icon(Icons.more_vert_outlined),
      itemBuilder: (_) {
        return optionMenu.map(_buildPopupMenuItem).toList();
      },
      onSelected: (value) {
        optionSelected?.call(value as int, node.data as File);
      },
    );
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
