import 'package:data/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_treeview/flutter_treeview.dart';

import '../../app/app.dart';
import '../../l10n/wording.dart';
import '../../widgets/dividers.dart';
import '../../widgets/icon_text_menu.dart';
import '../../widgets/tree/file_tree.dart';
import '../../widgets/view_dialogs.dart';
import '../bloc/file_list_bloc.dart';
import '../bloc/working_cubit.dart';
import '../utils/node_extension.dart';

class FileManager extends StatefulWidget {
  const FileManager({super.key});

  @override
  State<StatefulWidget> createState() => _FileManagerState();
}

class _FileManagerState extends State<FileManager> {
  late FileListBloc _fileListBloc;
  late FileTreeCubit _fileTreeCubit;
  late WorkingCubit _workingCubit;

  @override
  void initState() {
    super.initState();
    NotebookRepository notebookRepository = RepositoryProvider.of<NotebookRepository>(context);
    NoteRepository noteRepository = RepositoryProvider.of<NoteRepository>(context);
    _fileListBloc = FileListBloc(notebookRepository, noteRepository);
    _fileTreeCubit = FileTreeCubit(TreeViewController());
    _workingCubit = context.read<WorkingCubit>();
    _fileListBloc.add(LoadFileList());
  }

  void _openEditor(String id) {
    Scaffold.of(context).closeDrawer();
    Routes.open(Routes.routeEditor, args: id);
  }

  Future<void> _addNotebook({String? parentId = ''}) async {
    String name = await ViewDialogs.editorDialog(
      context,
      S.of(context).addNotebook,
      editorHint: S.of(context).nameInputHint,
    );
    _fileListBloc.add(AddNotebook(name));
  }

  Future<void> _updateNotebook(File file) async {
    String name = await ViewDialogs.editorDialog(
      context,
      S.of(context).editNotebook,
      editorHint: S.of(context).nameInputHint,
      initialText: file.label,
    );
    if (name.trim().isNotEmpty && name.trim() != file.label.trim()) {
      _fileListBloc.add(RenameNotebook(file.id ?? '', name));
    }
  }

  Future<void> _deleteNotebook(File file) async {
    ViewDialogsAction result = await ViewDialogs.simpleDialog(
      context,
      S.of(context).delete,
      S.of(context).deleteConfirmMessage(file.label),
    );
    if (result == ViewDialogsAction.yes) {
      _fileListBloc.add(DeleteNotebook(file.id ?? ''));
    }
  }

  void _addNote(String? parentId) async {
    if (parentId != null && parentId.isNotEmpty == true) {
      _fileListBloc.add(AddNote(parentId));
    }
  }

  void _editNote(String? id) {
    if (id != null && id.isNotEmpty == true) {
      Log.d('Edit note $id');
      _openEditor(id);
    }
  }

  void _updateNoteTitle(File file) async {
    String name = await ViewDialogs.editorDialog(
      context,
      S.of(context).renameNote,
      editorHint: S.of(context).nameInputHint,
      initialText: file.label,
    );
    if (name.trim().isNotEmpty && name.trim() != file.label.trim()) {
      _fileListBloc.add(RenameNote(file.id ?? '', name));
    }
  }

  void _deleteNote(File file) async {
    ViewDialogsAction result = await ViewDialogs.simpleDialog(
      context,
      S.of(context).delete,
      S.of(context).deleteConfirmMessage(file.label),
    );
    if (result == ViewDialogsAction.yes) {
      _fileListBloc.add(DeleteNote(file.id ?? ''));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FileListBloc>(
      create: (_) => _fileListBloc,
      child: BlocListener<FileListBloc, FileListState>(
        listener: _onFileListChanged,
        child: Column(
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
        ),
      ),
    );
  }

  Widget _fileList(BuildContext context) {
    return BlocBuilder<FileListBloc, FileListState>(
        buildWhen: (previous, current) => current is FileListLoaded,
        builder: (context, state) {
          List<File> files = List.empty();
          if (state is FileListLoaded) {
            files = state.notebooks + state.notes;
          }
          if (files.isNotEmpty) {
            return BlocProvider(
              create: (_) => _fileTreeCubit,
              child: BlocBuilder<FileListBloc, FileListState>(
                builder: (context, state) {
                  return FileTree(
                    onNodeTap: _handleFileSelected,
                    onNodeDoubleTap: _handleFileDoubleTap,
                    onExpansionChanged: _handleFolderExpansion,
                    notebookOptions: _notebookOptions(),
                    notebookOptionSelected: _onNotebookOptionSelected,
                    noteOptions: _noteOptions(),
                    noteOptionSelected: _onNoteOptionSelected,
                    supportParentDoubleTap: true,
                  );
                },
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

  void _handleFileSelected(TreeViewController controller, String id) {
    File? file = controller.getNode(id)?.data as File?;
    if (file != null && !file.isFolder) {
      _workingCubit.open(id);
      _openEditor(id);
    }
  }

  void _handleFileDoubleTap(TreeViewController controller, String id) {
    File? file = controller.getNode(id)?.data as File?;
    if (file != null) {
      if (!file.isFolder) {
        _workingCubit.open(id);
        _openEditor(id);
      } else {
        //todo: open notebook editor
      }
    }
  }

  void _handleFolderExpansion(TreeViewController controller, String id, bool expanded) {
    File? file = controller.getNode(id)?.data as File?;
    if (file != null && expanded) {
      _workingCubit.cd(id);
    }
  }

  List<MenuData> _notebookOptions() {
    return [
      MenuData(0, S.of(context).addNote),
      MenuData(1, S.of(context).addNotebook),
      MenuData(2, S.of(context).edit),
      MenuData(3, S.of(context).delete),
      MenuData(4, S.of(context).moveTo),
    ];
  }

  void _onNotebookOptionSelected(int id, File file) {
    switch (id) {
      case 0:
        {
          _addNote(file.id);
          break;
        }
      case 1:
        {
          _addNotebook(parentId: file.id);
          break;
        }
      case 2:
        {
          _updateNotebook(file);
          break;
        }
      case 3:
        {
          _deleteNotebook(file);
          break;
        }
      case 4:
        {
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
          _editNote(file.id);
          break;
        }
      case 1:
        {
          break;
        }
      case 2:
        {
          _updateNoteTitle(file);
          break;
        }
      case 3:
        {
          _deleteNote(file);
          break;
        }
      default:
        {
          break;
        }
    }
  }

  void _onFileListChanged(BuildContext context, FileListState state) {
    if (state is FileListLoaded) {
      _fileTreeCubit.set(NodeMapper.of(state.notebooks, state.notes));
    } else if (state is FileLoadError) {
      Log.d('Load files error ${state.message}');
    } else if (state is FileAdded) {
      if (state.parentId?.isNotEmpty == true) {
        _fileTreeCubit.add(state.parentId ?? '', state.file);
      } else {
        _fileTreeCubit.addToRoot(state.file);
      }
      if (!state.file.isParent) {
        _openEditor(state.file.key);
      }
    } else if (state is FileChanged) {
      _fileTreeCubit.update(state.file);
    } else if (state is FileDeleted) {
      _fileTreeCubit.delete(state.id);
    } else if (state is FileOpError) {
      Log.d('File op error ${state.message}');
    }
  }

  @override
  void dispose() {
    _fileTreeCubit.close();
    super.dispose();
  }
}
