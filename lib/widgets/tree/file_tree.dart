import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_treeview/flutter_treeview.dart';

import 'file.dart';
import 'file_tree_cubit.dart';
import 'file_tree_item.dart';

export 'file.dart';
export 'file_tree_cubit.dart';
export 'file_tree_item.dart';

class FileTree extends StatefulWidget {
  const FileTree({
    Key? key,
    this.onNodeTap,
    this.onNodeDoubleTap,
    this.onExpansionChanged,
    this.initialNodes = const [],
  }) : super(key: key);

  final List<Node> initialNodes;
  final Function(TreeViewController, String)? onNodeTap;
  final Function(TreeViewController, String)? onNodeDoubleTap;
  final Function(TreeViewController, String, bool)? onExpansionChanged;

  @override
  State<StatefulWidget> createState() {
    return _FileTreeState();
  }
}

class _FileTreeState extends State<FileTree> {
  late TreeViewController _treeViewController;

  @override
  void initState() {
    super.initState();
    _treeViewController = TreeViewController(children: widget.initialNodes);
  }

  Widget _createNode(BuildContext context, Node<dynamic> node) {
    if (node.hasData) {
      return FileTreeItem(node: node as FileNode);
    } else {
      return const SizedBox.shrink();
    }
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

  @override
  Widget build(BuildContext context) {
    return BlocListener<FileTreeCubit, List<FileNode>>(
      listener: (context, state) {
        setState(() {
          var selectedKey = _treeViewController.selectedKey;
          _treeViewController = TreeViewController(children: state, selectedKey: selectedKey);
        });
      },
      child: TreeView(
        controller: _treeViewController,
        allowParentSelect: false,
        onNodeTap: (key) => widget.onNodeTap?.call(_treeViewController, key),
        onNodeDoubleTap: (key) => widget.onNodeDoubleTap?.call(_treeViewController, key),
        onExpansionChanged: (key, expanded) {
          _expand(key, expanded);
          widget.onExpansionChanged?.call(_treeViewController, key, expanded);
        },
        nodeBuilder: _createNode,
        theme: TreeViewTheme(
          expanderTheme: const ExpanderThemeData(type: ExpanderType.none),
          colorScheme: Theme.of(context).colorScheme,
        ),
      ),
    );
  }
}
