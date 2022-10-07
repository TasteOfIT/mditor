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
    this.notebookOptions = const [],
    this.notebookOptionSelected,
    this.noteOptions = const [],
    this.noteOptionSelected,
    this.supportParentDoubleTap = false,
  }) : super(key: key);

  final Function(TreeViewController, String)? onNodeTap;
  final Function(TreeViewController, String)? onNodeDoubleTap;
  final Function(TreeViewController, String, bool)? onExpansionChanged;
  final List<MenuData> notebookOptions;
  final void Function(int, File)? notebookOptionSelected;
  final List<MenuData> noteOptions;
  final void Function(int, File)? noteOptionSelected;
  final bool supportParentDoubleTap;

  @override
  State<StatefulWidget> createState() {
    return _FileTreeState();
  }
}

class _FileTreeState extends State<FileTree> {
  late FileTreeCubit _fileTreeCubit;

  @override
  void initState() {
    super.initState();
    _fileTreeCubit = context.read<FileTreeCubit>();
  }

  Widget _createNode(BuildContext context, Node<dynamic> node) {
    if (node is FileNode) {
      if ((node.data as File).isFolder) {
        return FileTreeItem(
          node: node,
          optionMenu: widget.notebookOptions,
          optionSelected: widget.notebookOptionSelected,
        );
      } else {
        return FileTreeItem(
          node: node,
          optionMenu: widget.noteOptions,
          optionSelected: widget.noteOptionSelected,
        );
      }
    } else {
      return const SizedBox.shrink();
    }
  }

  void _expand(String key, bool expanded) {
    _fileTreeCubit.expand(key, expanded);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FileTreeCubit, TreeViewController>(builder: (context, state) {
      return TreeView(
        controller: state,
        allowParentSelect: false,
        supportParentDoubleTap: widget.supportParentDoubleTap,
        onNodeTap: (key) => widget.onNodeTap?.call(state, key),
        onNodeDoubleTap: (key) => widget.onNodeDoubleTap?.call(state, key),
        onExpansionChanged: (key, expanded) {
          _expand(key, expanded);
          widget.onExpansionChanged?.call(state, key, expanded);
        },
        nodeBuilder: _createNode,
        theme: TreeViewTheme(
          expanderTheme: const ExpanderThemeData(
            type: ExpanderType.chevron,
            modifier: ExpanderModifier.circleOutlined,
            size: 24,
          ),
          colorScheme: Theme.of(context).colorScheme,
        ),
      );
    });
  }
}
