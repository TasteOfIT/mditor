import 'package:flutter/material.dart';
import 'package:flutter_treeview/flutter_treeview.dart';

import 'file.dart';
import 'file_tree_item.dart';

export 'file.dart';
export 'file_tree_item.dart';

class FileTree extends StatelessWidget {
  const FileTree({
    Key? key,
    required this.treeViewController,
    this.emptyMessage = '',
    this.onNodeTap,
    this.onNodeDoubleTap,
    this.onExpansionChanged,
  }) : super(key: key);

  final TreeViewController treeViewController;
  final String? emptyMessage;
  final Function(TreeViewController, String)? onNodeTap;
  final Function(TreeViewController, String)? onNodeDoubleTap;
  final Function(TreeViewController, String, bool)? onExpansionChanged;

  Widget _createNode(BuildContext context, Node<dynamic> node) {
    if (node.hasData) {
      return FileTreeItem(node: node as FileNode);
    } else {
      return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (treeViewController.children.isNotEmpty) {
      return TreeView(
        controller: treeViewController,
        allowParentSelect: false,
        onNodeTap: (key) => onNodeTap?.call(treeViewController, key),
        onNodeDoubleTap: (key) => onNodeDoubleTap?.call(treeViewController, key),
        onExpansionChanged: (key, expanded) => onExpansionChanged?.call(treeViewController, key, expanded),
        nodeBuilder: _createNode,
        theme: TreeViewTheme(
          expanderTheme: const ExpanderThemeData(type: ExpanderType.none),
          colorScheme: Theme.of(context).colorScheme,
        ),
      );
    } else {
      return Center(
        child: Text(
          emptyMessage ?? '',
          style: TextStyle(color: Theme.of(context).hintColor),
        ),
      );
    }
  }
}
