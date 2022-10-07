import 'package:bloc/bloc.dart';
import 'package:data/data.dart';
import 'package:equatable/equatable.dart';

import '../../app/app.dart';
import '../../home/utils/node_extension.dart';
import '../../widgets/tree/file.dart';

part 'notes_event.dart';

part 'notes_state.dart';

enum SortOrder {
  createdTimeAsc,
  createdTimeDesc,
  nameAsc,
  nameDesc;
}

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  final NotebookRepository _notebookRepo;
  final NoteRepository _noteRepo;

  Notebook? _currentNotebook;
  List<File>? _latestNotes;

  NotesBloc(this._notebookRepo, this._noteRepo) : super(NotesInitial()) {
    on<LoadNotes>(_loadNotes);
    on<AddNote>(_addNote);
    on<RenameNote>(_renameNote);
    on<DeleteNote>(_deleteNote);
    on<AddNotebook>(_addNotebook);
    on<RenameNotebook>(_renameNotebook);
    on<DeleteNotebook>(_deleteNotebook);
  }

  void _loadNotes(LoadNotes event, Emitter<NotesState> emit) async {
    if (event.id?.isNotEmpty != true) {
      emit(NotesInitial());
    } else {
      _currentNotebook = await _notebookRepo.getNotebook(event.id ?? '');
      if (_currentNotebook != null && _currentNotebook?.id?.isNotEmpty == true) {
        List<Notebook> notebooks = await _notebookRepo.getNotebooksIn(event.id ?? '').timeout(
              const Duration(seconds: 5),
              onTimeout: List.empty,
            );
        List<NoteItem> notes = await _noteRepo.getNotesIn(event.id ?? '').timeout(
              const Duration(seconds: 5),
              onTimeout: List.empty,
            );
        _latestNotes = NodeMapper.fromNotebooks(notebooks) + NodeMapper.fromItems(notes);
        emit(NotesLoaded(
          _currentNotebook?.id ?? '',
          _currentNotebook?.title ?? '',
          _latestNotes ?? List.empty(),
        ));
      } else {
        Log.e('Cannot found ${event.id}');
      }
    }
  }

  void _addNotebook(AddNotebook event, Emitter<NotesState> emit) async {
    assert(_currentNotebook?.id?.isNotEmpty == true);
    if (event.name.trim().isNotEmpty) {
      String id = await _notebookRepo.addNotebook(event.name.trim(), _currentNotebook?.id);
      Log.d('Insert notebook $id');
      if (id.isNotEmpty) {
        File? notebook = await _getNotebook(id);
        if (notebook != null) {
          _latestNotes?.add(notebook);
          emit(NotesLoaded(
            _currentNotebook?.id ?? '',
            _currentNotebook?.title ?? '',
            _latestNotes ?? List.empty(),
          ));
        }
      }
    }
  }

  void _renameNotebook(RenameNotebook event, Emitter<NotesState> emit) async {
    assert(_currentNotebook?.id?.isNotEmpty == true);
    if (event.id.isNotEmpty && event.name.trim().isNotEmpty) {
      int result = await _notebookRepo.updateNotebook(event.id, event.name.trim());
      Log.d('Update notebook $result');
      if (result == 1) {
        File? notebook = await _getNotebook(event.id);
        if (notebook != null) {
          _latestNotes?.removeWhere((element) => element.id == event.id);
          _latestNotes?.add(notebook);
          emit(NotesLoaded(
            _currentNotebook?.id ?? '',
            _currentNotebook?.title ?? '',
            _latestNotes ?? List.empty(),
          ));
        }
      }
    }
  }

  void _deleteNotebook(DeleteNotebook event, Emitter<NotesState> emit) async {
    assert(_currentNotebook?.id?.isNotEmpty == true);
    if (event.id.isNotEmpty) {
      // todo: delete all children
      int result = await _notebookRepo.removeNotebook(event.id);
      Log.d('Delete notebook $result');
      if (result == 1) {
        _latestNotes?.removeWhere((element) => element.id == event.id);
        emit(NotesLoaded(
          _currentNotebook?.id ?? '',
          _currentNotebook?.title ?? '',
          _latestNotes ?? List.empty(),
        ));
      }
    }
  }

  void _addNote(AddNote event, Emitter<NotesState> emit) async {
    assert(_currentNotebook?.id?.isNotEmpty == true);
    String noteId = await _noteRepo.addNote(_currentNotebook?.id ?? '', '', '');
    Log.d('Insert note $noteId');
    if (noteId.isNotEmpty) {
      File? note = await _getNote(noteId);
      if (note != null) {
        _latestNotes?.add(note);
        emit(NotesLoaded(
          _currentNotebook?.id ?? '',
          _currentNotebook?.title ?? '',
          _latestNotes ?? List.empty(),
        ));
      }
    }
  }

  void _renameNote(RenameNote event, Emitter<NotesState> emit) async {
    assert(_currentNotebook?.id?.isNotEmpty == true);
    if (event.id.isNotEmpty && event.name.trim().isNotEmpty) {
      int result = await _noteRepo.updateTitle(event.id, event.name.trim());
      Log.d(' Update note $result');
      if (result == 1) {
        File? note = await _getNote(event.id);
        if (note != null) {
          _latestNotes?.removeWhere((element) => element.id == event.id);
          _latestNotes?.add(note);
          emit(NotesLoaded(
            _currentNotebook?.id ?? '',
            _currentNotebook?.title ?? '',
            _latestNotes ?? List.empty(),
          ));
        }
      }
    }
  }

  void _deleteNote(DeleteNote event, Emitter<NotesState> emit) async {
    assert(_currentNotebook?.id?.isNotEmpty == true);
    if (event.id.isNotEmpty) {
      int result = await _noteRepo.removeNote(event.id);
      Log.d('Delete note $result');
      if (result == 1) {
        _latestNotes?.removeWhere((element) => element.id == event.id);
        emit(NotesLoaded(
          _currentNotebook?.id ?? '',
          _currentNotebook?.title ?? '',
          _latestNotes ?? List.empty(),
        ));
      }
    }
  }

  Future<File?> _getNote(String id) async {
    return _noteRepo.getNote(id).then((value) {
      if (value != null) {
        return File.fromNoteItem(value);
      }
      return null;
    });
  }

  Future<File?> _getNotebook(String id) async {
    return _notebookRepo.getNotebook(id).then((value) {
      if (value != null) {
        return File.fromNotebook(value);
      }
      return null;
    });
  }
}
