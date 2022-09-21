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

  StreamSubscription<List<Notebook>>? _notebooksSubscription;

  FileListBloc(this._notebookRepo) : super(FileListData(List.empty())) {
    on<FileListRefresh>(_onRefresh, transformer: restartable());
    on<FileListLoaded>(_onLoaded);
  }

  void _onRefresh(FileListRefresh event, Emitter<FileListState> emit) async {
    emit(FileListLoading());
    _notebooksSubscription?.cancel();
    _notebooksSubscription = _notebookRepo.getNotebooks().listen(
      (data) {
        List<Notebook> notebooks = data;
        Log.d('New data $notebooks');
        add(FileListLoaded(notebooks));
      },
    );
  }

  @override
  Future<void> close() {
    _notebooksSubscription?.cancel();
    return super.close();
  }

  void _onLoaded(FileListLoaded event, Emitter<FileListState> emit) {
    emit(FileListData(NodeMapper.of(event.notebooks, List.empty())));
  }
}
