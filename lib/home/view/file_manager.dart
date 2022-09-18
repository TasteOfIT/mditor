import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_treeview/flutter_treeview.dart';

import '../../l10n/wording.dart';
import '../../widgets/tree/file_tree.dart';
import '../cubit/file_list_bloc.dart';

class FileManager extends StatefulWidget {
  const FileManager({super.key});

  @override
  State<StatefulWidget> createState() => _FileManagerState();
}

class _FileManagerState extends State<FileManager> {
  void _expand(TreeViewController treeViewController, String key, bool expanded) {
    final Node? node = treeViewController.getNode(key);
    if (node != null) {
      List<Node> updated = treeViewController.updateNode(key, node.copyWith(expanded: expanded));
      setState(() {
        treeViewController = treeViewController.copyWith(children: updated);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FileListBloc, FileListState>(builder: (context, state) {
      List<FileNode> files = List.empty();
      if (state is FileListData) {
        files = state.nodes;
      }
      return FileTree(
        treeViewController: TreeViewController(children: files),
        emptyMessage: S.of(context).noNotebooks,
        onExpansionChanged: _expand,
      );
    });
  }
}
