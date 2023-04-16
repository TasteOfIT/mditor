import 'package:flutter/material.dart';

import '../../locale/locale.dart';
import '../model/file.dart';
import 'file_tree.dart';

class FilePickerItem<File> extends StatelessWidget {
  const FilePickerItem({
    Key? key,
    required this.node,
    required this.selectedKey,
    required this.isSelectable,
    this.onAction,
  }) : super(key: key);

  final FileNode node;
  final String? selectedKey;
  final bool isSelectable;
  final void Function(String)? onAction;

  @override
  Widget build(BuildContext context) {
    String label = node.label;
    if (label.trim().isEmpty) {
      label = S.of(context).nameInputHint;
    }
    Color background = Theme.of(context).backgroundColor;
    if (!isSelectable) {
      background = Theme.of(context).disabledColor;
    } else if (node.key == selectedKey) {
      background = Theme.of(context).highlightColor;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
      color: background,
      child: Row(
        children: [
          _leadingIcon(context),
          Expanded(
            flex: 1,
            child: Text(
              node.label,
              maxLines: 1,
              style: const TextStyle(
                fontSize: 20,
                letterSpacing: 0.3,
                overflow: TextOverflow.clip,
              ),
            ),
          ),
          _trailingIcon(context, node),
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
        size: 30,
      ),
    );
  }

  Widget _trailingIcon(BuildContext context, FileNode node) {
    return Center(
      widthFactor: 2.0,
      child: Radio<String>(
        value: node.key,
        groupValue: isSelectable ? selectedKey : node.key,
        toggleable: true,
        onChanged: isSelectable ? (key) => onAction?.call(key ?? '') : null,
      ),
    );
  }
}
