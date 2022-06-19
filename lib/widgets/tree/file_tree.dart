import 'package:flutter/material.dart';
import 'package:flutter_treeview/flutter_treeview.dart';

import 'file_tree_item.dart';

class FileTree<T extends Node> extends StatefulWidget {
  const FileTree({
    Key? key,
    this.nodes = const [],
    this.onNodeTap,
    this.onNodeDoubleTap,
    this.onExpansionChanged,
    this.emptyMessage = '',
  }) : super(key: key);

  final String? emptyMessage;
  final List<Node> nodes;
  final Function(String)? onNodeTap;
  final Function(String)? onNodeDoubleTap;
  final Function(String, bool)? onExpansionChanged;

  @override
  State<StatefulWidget> createState() {
    return _FileTreeState();
  }
}

class _FileTreeState<T extends Node> extends State<FileTree<T>> {
  TreeViewController _treeViewController = TreeViewController();

  @override
  void initState() {
    super.initState();
    _treeViewController = TreeViewController(children: widget.nodes);
  }

  void _expand(String key, bool expanded) {
    final Node? node = _treeViewController.getNode(key);
    if (node != null) {
      List<Node> updated = _treeViewController.updateNode(key, node.copyWith(expanded: expanded));
      setState(() {
        _treeViewController = _treeViewController.copyWith(children: updated);
      });
    }
  }

  Widget _createNode(BuildContext context, Node<dynamic> node) {
    if (node.hasData) {
      return FileTreeItem(node: node);
    } else {
      return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.nodes.isNotEmpty) {
      return TreeView(
        controller: _treeViewController,
        allowParentSelect: false,
        onNodeTap: (key) => widget.onNodeTap?.call(key),
        onNodeDoubleTap: (key) => widget.onNodeDoubleTap?.call(key),
        onExpansionChanged: (key, expanded) {
          _expand(key, expanded);
          widget.onExpansionChanged?.call(key, expanded);
        },
        nodeBuilder: _createNode,
      );
    } else {
      return Center(
        child: Text(
          widget.emptyMessage ?? '',
          style: TextStyle(color: Theme.of(context).hintColor),
        ),
      );
    }
  }
}
