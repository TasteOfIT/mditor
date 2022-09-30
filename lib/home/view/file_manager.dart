import 'package:data/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../app/app.dart';
import '../../l10n/wording.dart';
import '../../widgets/dividers.dart';
import '../../widgets/icon_text_menu.dart';
import '../../widgets/tree/file_tree.dart';
import '../../widgets/view_dialogs.dart';
import '../bloc/file_list_bloc.dart';

class FileManager extends StatefulWidget {
  const FileManager({super.key});

  @override
  State<StatefulWidget> createState() => _FileManagerState();
}

class _FileManagerState extends State<FileManager> {
  final FileTreeCubit _fileTreeCubit = FileTreeCubit();
  late NotebookRepository _notebookRepository;

  @override
  void initState() {
    super.initState();
    _notebookRepository = RepositoryProvider.of<NotebookRepository>(context);
  }

  Future<void> _addNotebook() async {
    String name = await ViewDialogs.editorDialog(context, S.of(context).addNotebook);
    if (name.trim().isNotEmpty) {
      int result = await _notebookRepository.addNotebook(name.trim());
      Log.d('Insert $result');
    }
  }

  Future<void> _deleteNotebook(File file) async {
    ViewDialogsAction result = await ViewDialogs.simpleDialog(
      context,
      S.of(context).delete,
      S.of(context).deleteConfirmMessage(file.label),
    );
    if (result == ViewDialogsAction.yes) {
      // todo: delete all children
      int result = await _notebookRepository.removeNotebook(file.id ?? '');
      Log.d('Delete $result');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconTextMenu(
          icon: Icons.my_library_books_rounded,
          action: Icons.note_add_rounded,
          label: S.of(context).notebooks,
          onAction: _addNotebook,
        ),
        Dividers.horizontal(),
        Expanded(
          flex: 1,
          child: _fileList(context),
        ),
      ],
    );
  }

  Widget _fileList(BuildContext context) {
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
              notebookOptions: _notebookOptions(),
              notebookOptionSelected: _onNotebookOptionSelected,
              noteOptions: _noteOptions(),
              noteOptionSelected: _onNoteOptionSelected,
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

  List<MenuData> _notebookOptions() {
    return [
      MenuData(0, S.of(context).addNote),
      MenuData(1, S.of(context).addNotebook),
      MenuData(2, S.of(context).edit),
      MenuData(3, S.of(context).delete),
    ];
  }

  void _onNotebookOptionSelected(int id, File file) {
    switch (id) {
      case 0:
        {
          break;
        }
      case 1:
        {
          _addNotebook();
          break;
        }
      case 2:
        {
          break;
        }
      case 3:
        {
          _deleteNotebook(file);
          break;
        }
      default:
        {
          break;
        }
    }
  }

  List<MenuData> _noteOptions() {
    return [
      MenuData(0, S.of(context).edit),
      MenuData(1, S.of(context).moveTo),
      MenuData(2, S.of(context).rename),
      MenuData(3, S.of(context).delete),
    ];
  }

  void _onNoteOptionSelected(int id, File file) {
    switch (id) {
      case 0:
        {
          break;
        }
      case 1:
        {
          break;
        }
      case 2:
        {
          break;
        }
      case 3:
        {
          break;
        }
      default:
        {
          break;
        }
    }
  }

  @override
  void dispose() {
    _fileTreeCubit.close();
    super.dispose();
  }
}
