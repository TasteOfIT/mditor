import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:data/data.dart';
import 'package:equatable/equatable.dart';

import '../../app/log.dart';
import '../../widgets/tree/file_tree.dart';
import '../utils/node_extension.dart';

part 'file_list_event.dart';

part 'file_list_state.dart';

class FileListBloc extends Bloc<FileListEvent, FileListState> {
  final NotebookRepository _notebookRepo;
  final NoteRepository _noteRepo;

  StreamSubscription<List<Notebook>>? _notebooksSubscription;
  StreamSubscription<List<NoteItem>>? _notesSubscription;

  List<Notebook>? _latestNotebooks;
  List<NoteItem>? _latestNotes;

  FileListBloc(this._notebookRepo, this._noteRepo) : super(FileListData(List.empty(), List.empty())) {
    on<FileListRefresh>(_onRefresh, transformer: restartable());
    on<FileListLoaded>(_onLoaded);
  }

  void _onRefresh(FileListRefresh event, Emitter<FileListState> emit) async {
    emit(FileListLoading());
    _notebooksSubscription?.cancel();
    _notebooksSubscription = _notebookRepo.getNotebooks().listen(
      (data) {
        _latestNotebooks = data;
        Log.d('Notebooks changed ${_latestNotebooks?.length ?? -1}');
        if (_latestNotes != null) add(FileListLoaded(data, _latestNotes ?? List.empty()));
      },
    );
    _notesSubscription?.cancel();
    _notesSubscription = _noteRepo.getNotes().listen(
      (data) {
        _latestNotes = data;
        Log.d('Notes changed ${_latestNotes?.length ?? -1}');
        if (_latestNotebooks != null) add(FileListLoaded(_latestNotebooks ?? List.empty(), data));
      },
    );
  }

  @override
  Future<void> close() {
    _notebooksSubscription?.cancel();
    return super.close();
  }

  void _onLoaded(FileListLoaded event, Emitter<FileListState> emit) {
    emit(FileListData(NodeMapper.fromNotebooks(event.notebooks), NodeMapper.fromItems(event.notes)));
  }
}
