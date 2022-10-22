import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_treeview/flutter_treeview.dart';

import '../model/file.dart';
import 'file_picker_cubit.dart';
import 'file_picker_item.dart';

export '../model/file.dart';
export 'file_tree_cubit.dart';
export 'file_tree_item.dart';

enum PickMode {
  both,
  file,
  folder;

  bool isFolderPickable() {
    return this == both || this == folder;
  }
}

class FilePicker extends StatefulWidget {
  const FilePicker({
    super.key,
    required this.selectedKey,
    this.pickMode = PickMode.both,
    this.onSelectedItemChanged,
  });

  final String selectedKey;
  final PickMode pickMode;
  final void Function(String)? onSelectedItemChanged;

  @override
  State<StatefulWidget> createState() {
    return _FilePickerState();
  }
}

class _FilePickerState extends State<FilePicker> {
  late FilePickerCubit _filePickerCubit;

  @override
  void initState() {
    super.initState();
    _filePickerCubit = context.read<FilePickerCubit>();
  }

  Widget _createNode(BuildContext context, Node<dynamic> node) {
    if (node is FileNode) {
      return FilePickerItem(
        node: node,
        selectedKey: _filePickerCubit.state.selectedKey,
        isSelectable: widget.selectedKey != node.key,
        onAction: (key) => widget.onSelectedItemChanged?.call(key),
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  void _expand(String key, bool expanded) {
    _filePickerCubit.expand(key, expanded);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilePickerCubit, TreeViewController>(builder: (context, state) {
      return TreeView(
        controller: state,
        allowParentSelect: false,
        supportParentDoubleTap: false,
        onNodeTap: (key) => {},
        onExpansionChanged: _expand,
        nodeBuilder: _createNode,
        theme: TreeViewTheme(
          expanderTheme: const ExpanderThemeData(
            type: ExpanderType.none,
            size: 28,
          ),
          colorScheme: Theme.of(context).colorScheme,
        ),
      );
    });
  }
}
