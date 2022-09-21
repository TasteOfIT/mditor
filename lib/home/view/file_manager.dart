import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../l10n/wording.dart';
import '../../widgets/tree/file_tree.dart';
import '../bloc/file_list_bloc.dart';

class FileManager extends StatefulWidget {
  const FileManager({super.key});

  @override
  State<StatefulWidget> createState() => _FileManagerState();
}

class _FileManagerState extends State<FileManager> {
  final FileTreeCubit _fileTreeCubit = FileTreeCubit();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FileListBloc, FileListState>(builder: (context, state) {
      List<FileNode> files = List.empty();
      if (state is FileListData) {
        files = state.nodes;
      }
      if (files.isNotEmpty) {
        return BlocProvider(
          create: (_) => _fileTreeCubit,
          child: BlocListener<FileListBloc, FileListState>(
            listener: (context, state) {
              if (state is FileListData) {
                _fileTreeCubit.update(state.nodes);
              }
            },
            child: FileTree(
              initialNodes: files,
            ),
          ),
        );
      } else {
        return Center(
          child: Text(
            S.of(context).noNotebooks,
            style: TextStyle(color: Theme.of(context).hintColor),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _fileTreeCubit.close();
    super.dispose();
  }
}
