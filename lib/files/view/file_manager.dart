import 'package:common/common.dart';
import 'package:common/widgets.dart';
import 'package:data/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_treeview/flutter_treeview.dart';

import '../../app/app.dart';
import '../../locale/locale.dart';
import '../../widgets/tree/file_tree.dart';
import '../bloc/file_list_bloc.dart';
import '../bloc/working_cubit.dart';
import '../utils/file_extension.dart';
import 'file_dialogs.dart';

class FileManager extends StatefulWidget {
  const FileManager({super.key});

  @override
  State<StatefulWidget> createState() => _FileManagerState();
}

class _FileManagerState extends State<FileManager> {
  late FileListBloc _fileListBloc;
  late FileTreeCubit _fileTreeCubit;
  late WorkingCubit _workingCubit;
  bool _isFileListEmpty = true;

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

  void _openNotebook(String id) {
    Scaffold.of(context).closeDrawer();
    Routes.open(Routes.routeNotes, args: id);
  }

  Future<void> _addNotebook({String? parentId = ''}) async {
    await FileDialogs.addNotebook(context, (name) {
      _fileListBloc.add(AddNotebook(name, parentId: parentId));
    });
  }

  Future<void> _updateNotebook(File file) async {
    await FileDialogs.renameNotebook(context, file.label, (name) {
      _fileListBloc.add(RenameNotebook(file.id ?? '', name));
    });
  }

  Future<void> _deleteNotebook(File file) async {
    await FileDialogs.deleteFile(context, file.label, () {
      _fileListBloc.add(DeleteNotebook(file.id ?? '', file.parentId));
    });
  }

  Future<void> _addNote(String? parentId) async {
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

  Future<void> _updateNoteTitle(File file) async {
    await FileDialogs.renameNote(context, file.label, (name) {
      _fileListBloc.add(RenameNote(file.id ?? '', name));
    });
  }

  Future<void> _deleteNote(File file) async {
    await FileDialogs.deleteFile(context, file.label, () {
      _fileListBloc.add(DeleteNote(file.id ?? '', file.parentId));
    });
  }

  void _openPicker(String? id, bool isFolder) async {
    if (id != null && id.isNotEmpty == true) {
      String newParent = await Routes.add(Routes.routePicker, args: id) ?? '';
      Log.d('Picked $newParent for $id');
      if (isFolder) {
        _fileListBloc.add(MoveNotebook(id, newParent));
      } else {
        _fileListBloc.add(MoveNote(id, newParent));
      }
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
    if (!_isFileListEmpty) {
      return BlocProvider(
        create: (_) => _fileTreeCubit,
        child: FileTree(
          onNodeTap: _handleFileSelected,
          onNodeDoubleTap: _handleFileDoubleTap,
          onExpansionChanged: _handleFolderExpansion,
          notebookOptions: _notebookOptions(),
          notebookOptionSelected: _onNotebookOptionSelected,
          noteOptions: _noteOptions(),
          noteOptionSelected: _onNoteOptionSelected,
          supportParentDoubleTap: true,
        ),
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            S.of(context).noNotebooks,
            style: Theme.of(context).textTheme.headline4,
            textAlign: TextAlign.center,
          ),
          SizedBox.fromSize(
            size: const Size.fromHeight(20),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              S.of(context).noNotebooksHint,
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      );
    }
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
        _workingCubit.goTo(id);
        _openNotebook(id);
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
          _openPicker(file.id, file.isFolder);
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
          _openPicker(file.id, file.isFolder);
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
      List<FileNode> files = FilesExt.of(state.notebooks, notes: state.notes);
      _fileTreeCubit.set(files);
    } else if (state is FileLoadError) {
      Log.d('Load files error ${state.message}');
    } else if (state is FileAdded) {
      if (state.parentId?.isNotEmpty == true) {
        _fileTreeCubit.add(state.parentId ?? '', state.file);
      } else {
        _fileTreeCubit.addToRoot(state.file);
      }
      if (!state.file.isParent) {
        _workingCubit.open(state.file.key);
        _workingCubit.cd(state.parentId);
        _openEditor(state.file.key);
      }
    } else if (state is FileChanged) {
      _fileTreeCubit.update(state.file);
    } else if (state is FileDeleted) {
      _fileTreeCubit.delete(state.id);
      if (_workingCubit.state.notebookId == state.id) {
        _workingCubit.cd(state.parentId);
      } else if (_workingCubit.state.noteId == state.id) {
        _openNotebook(state.parentId ?? '');
      }
    } else if (state is FileMoved) {
      _workingCubit.cd(state.parentId);
      _openNotebook(state.parentId);
    } else if (state is FileOpError) {
      Log.d('File op error ${state.message}');
    }
    setState(() {
      _isFileListEmpty = _fileTreeCubit.state.children.isEmpty;
    });
  }

  @override
  void dispose() {
    _fileTreeCubit.close();
    super.dispose();
  }
}
