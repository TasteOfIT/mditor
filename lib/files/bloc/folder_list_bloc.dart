import 'package:bloc/bloc.dart';
import 'package:data/data.dart';
import 'package:equatable/equatable.dart';

import '../../widgets/model/file.dart';
import '../files.dart';

part 'folder_list_event.dart';

part 'folder_list_state.dart';

class FolderListBloc extends Bloc<FolderListEvent, FolderListState> {
  final NotebookRepository _notebookRepo;
  final NoteRepository _noteRepo;

  File? _fileToMove;
  List<Notebook>? _allNotebooks;

  FolderListBloc(this._notebookRepo, this._noteRepo) : super(FolderListLoaded(List.empty(), '')) {
    on<LoadFoldersList>(_loadFolders);
  }

  void _loadFolders(LoadFoldersList event, Emitter<FolderListState> emit) async {
    await _loadFile(event);
    _allNotebooks = await _notebookRepo
        .getNotebooks()
        .timeout(const Duration(seconds: 5), onTimeout: (sink) => sink.add(List.empty()))
        .first;
    _tryPublishFileList(emit);
  }

  Future<void> _loadFile(LoadFoldersList event) async {
    _fileToMove = await _noteRepo.getNote(event.id).then((note) {
      if (note == null) {
        return null;
      } else {
        return File.fromNoteItem(note);
      }
    });
    _fileToMove ??= await _notebookRepo.getNotebook(event.id).then((notebook) {
      if (notebook == null) {
        return null;
      } else {
        return File.fromNotebook(notebook);
      }
    });
  }

  void _tryPublishFileList(Emitter<FolderListState> emit) {
    if (_allNotebooks != null && _fileToMove != null) {
      emit(FolderListLoaded(
        FilesExt.fromNotebooks(_allNotebooks ?? List.empty()),
        _fileToMove?.parentId ?? '',
        selfId: _fileToMove?.isFolder == true ? _fileToMove?.id : '',
      ));
    } else if (_fileToMove == null) {
      emit(const FolderLoadError('Invalid file id to move'));
    } else {
      emit(const FolderLoadError('No info of folders'));
    }
  }
}
