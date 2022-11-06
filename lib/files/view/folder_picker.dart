import 'package:data/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_treeview/flutter_treeview.dart';

import '../../app/app.dart';
import '../../l10n/wording.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/tree/file_picker.dart';
import '../../widgets/tree/file_picker_cubit.dart';
import '../bloc/folder_list_bloc.dart';
import '../files.dart';

class FolderPicker extends StatefulWidget {
  const FolderPicker({super.key, required this.id});

  final String id;

  @override
  State<StatefulWidget> createState() {
    return _FolderPickerState();
  }
}

class _FolderPickerState extends State<FolderPicker> {
  late FolderListBloc _folderListBloc;
  late FilePickerCubit _filePickerCubit;
  String? _currentFolder;

  @override
  void initState() {
    super.initState();
    NotebookRepository notebookRepository = RepositoryProvider.of<NotebookRepository>(context);
    NoteRepository noteRepository = RepositoryProvider.of<NoteRepository>(context);
    _folderListBloc = FolderListBloc(notebookRepository, noteRepository);
    _filePickerCubit = FilePickerCubit(TreeViewController());
    _folderListBloc.add(LoadFoldersList(widget.id));
  }

  void _onItemSelected(String id) {
    if (_currentFolder != id) {
      _filePickerCubit.select(id);
    }
  }

  void _onConfirmed() {
    Routes.pop(result: _filePickerCubit.state.selectedKey);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FolderListBloc>(
      create: (_) => _folderListBloc,
      child: BlocListener<FolderListBloc, FolderListState>(
        listener: _onFolderListChanged,
        child: Scaffold(
          appBar: AppBarBuilder.get(
            S.of(context).moveTo,
            [ActionData(Icons.done_rounded, _onConfirmed)],
          ),
          body: BlocProvider(
            create: (_) => _filePickerCubit,
            child: _folderList(context),
          ),
        ),
      ),
    );
  }

  Widget _folderList(BuildContext context) {
    if (_currentFolder == null) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return FilePicker(
        selectedKey: _currentFolder ?? '',
        pickMode: PickMode.folder,
        onSelectedItemChanged: _onItemSelected,
      );
    }
  }

  void _onFolderListChanged(BuildContext context, FolderListState state) {
    if (state is FolderListLoaded) {
      if (state.notebooks.isNotEmpty) {
        _filePickerCubit.set(
          FilesExt.of(
            state.notebooks,
            excludedIds: state.selfId != null ? [state.selfId ?? ''] : [],
          ),
        );
        setState(() {
          _currentFolder = state.parentId;
        });
      }
    } else if (state is FolderLoadError) {
      Log.d('Load folders error ${state.message}');
    }
  }

  @override
  void dispose() {
    _filePickerCubit.close();
    super.dispose();
  }
}
