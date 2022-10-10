import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:data/data.dart';
import 'package:equatable/equatable.dart';

import '../../app/log.dart';
import '../../widgets/tree/file_tree.dart';
import '../utils/file_extension.dart';

part 'file_list_event.dart';

part 'file_list_state.dart';

class FileListBloc extends Bloc<FileListEvent, FileListState> {
  final NotebookRepository _notebookRepo;
  final NoteRepository _noteRepo;

  List<Notebook>? _latestNotebooks;
  List<NoteItem>? _latestNotes;

  FileListBloc(this._notebookRepo, this._noteRepo) : super(FileListLoaded(List.empty(), List.empty())) {
    on<LoadFileList>(_onRefresh, transformer: restartable());
    on<AddNotebook>(_addNotebook);
    on<RenameNotebook>(_renameNotebook);
    on<DeleteNotebook>(_deleteNotebook);
    on<AddNote>(_addNote);
    on<RenameNote>(_renameNote);
    on<DeleteNote>(_deleteNote);
  }

  void _onRefresh(LoadFileList event, Emitter<FileListState> emit) async {
    _latestNotebooks = await _notebookRepo
        .getNotebooks()
        .timeout(const Duration(seconds: 5), onTimeout: (sink) => sink.add(List.empty()))
        .first;
    Log.d('Notebooks changed ${_latestNotebooks?.length ?? -1}');

    _latestNotes = await _noteRepo
        .getNotes()
        .timeout(const Duration(seconds: 5), onTimeout: (sink) => sink.add(List.empty()))
        .first;
    Log.d('Notes changed ${_latestNotes?.length ?? -1}');
    _tryPublishFileList(emit);
  }

  void _tryPublishFileList(Emitter<FileListState> emit) {
    if (_latestNotes != null && _latestNotebooks != null) {
      emit(FileListLoaded(
        FilesExt.fromNotebooks(_latestNotebooks ?? List.empty()),
        FilesExt.fromItems(_latestNotes ?? List.empty()),
      ));
    }
  }

  void _addNotebook(AddNotebook event, Emitter<FileListState> emit) async {
    if (event.name.trim().isNotEmpty) {
      String id = await _notebookRepo.addNotebook(event.name.trim(), event.parentId);
      Log.d('Insert notebook $id');
      if (id.isNotEmpty) {
        FileNode? notebook = await _getNotebook(id);
        if (notebook != null) {
          emit(FileAdded(notebook, parentId: event.parentId));
        }
      }
    }
  }

  void _renameNotebook(RenameNotebook event, Emitter<FileListState> emit) async {
    if (event.id.isNotEmpty && event.name.trim().isNotEmpty) {
      int result = await _notebookRepo.updateNotebook(event.id, event.name.trim());
      Log.d('Update notebook $result');
      if (result == 1) {
        FileNode? notebook = await _getNotebook(event.id);
        if (notebook != null) {
          emit(FileChanged(event.id, notebook));
        }
      }
    }
  }

  void _deleteNotebook(DeleteNotebook event, Emitter<FileListState> emit) async {
    if (event.id.isNotEmpty) {
      int result = await _notebookRepo.removeNotebook(event.id);
      Log.d('Delete notebook $result');
      if (result == 1) {
        emit(FileDeleted(event.id, event.parentId));
      }
    }
  }

  void _addNote(AddNote event, Emitter<FileListState> emit) async {
    String noteId = await _noteRepo.addNote(event.parentId, '', '');
    Log.d('Insert note $noteId');
    if (noteId.isNotEmpty) {
      FileNode? note = await _getNote(noteId);
      if (note != null) {
        emit(FileAdded(note, parentId: event.parentId));
      }
    }
  }

  void _renameNote(RenameNote event, Emitter<FileListState> emit) async {
    if (event.id.isNotEmpty && event.name.trim().isNotEmpty) {
      int result = await _noteRepo.updateTitle(event.id, event.name.trim());
      Log.d(' Update note $result');
      if (result == 1) {
        FileNode? note = await _getNote(event.id);
        if (note != null) {
          emit(FileChanged(event.id, note));
        }
      }
    }
  }

  void _deleteNote(DeleteNote event, Emitter<FileListState> emit) async {
    if (event.id.isNotEmpty) {
      int result = await _noteRepo.removeNote(event.id);
      Log.d('Delete note $result');
      if (result == 1) {
        emit(FileDeleted(event.id, event.parentId));
      }
    }
  }

  Future<FileNode?> _getNote(String id) async {
    return _noteRepo.getNote(id).then((value) {
      if (value != null) {
        return FilesExt.toNode(File.fromNoteItem(value), false);
      }
      return null;
    });
  }

  Future<FileNode?> _getNotebook(String id) async {
    return _notebookRepo.getNotebook(id).then((value) {
      if (value != null) {
        return FilesExt.toNode(File.fromNotebook(value), true);
      }
      return null;
    });
  }
}
