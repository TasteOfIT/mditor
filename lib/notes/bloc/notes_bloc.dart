import 'dart:async';

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

  StreamSubscription<List<Notebook>>? _notebookSub;
  StreamSubscription<List<NoteItem>>? _noteSub;

  Notebook? _currentNotebook;
  List<File>? _latestNotebooks;
  List<File>? _latestNotes;

  NotesBloc(this._notebookRepo, this._noteRepo) : super(NotesInitial()) {
    on<LoadNotes>(_loadNotes);
    on<PublishNotes>(_publish);
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
        _notebookSub?.cancel();
        _notebookSub = _notebookRepo.getNotebooksIn(event.id ?? '').listen((data) {
          _latestNotebooks = NodeMapper.fromNotebooks(data);
          add(const PublishNotes());
        });
        _noteSub?.cancel();
        _noteSub = _noteRepo.getNotesIn(event.id ?? '').listen((data) {
          _latestNotes = NodeMapper.fromItems(data);
          add(const PublishNotes());
        });
      } else {
        emit(NotesError('Cannot found ${event.id}'));
      }
    }
  }

  void _addNotebook(AddNotebook event, Emitter<NotesState> emit) async {
    assert(_currentNotebook?.id?.isNotEmpty == true);
    if (event.name.trim().isNotEmpty) {
      String id = await _notebookRepo.addNotebook(event.name.trim(), _currentNotebook?.id);
      Log.d('Insert notebook $id');
    }
  }

  void _renameNotebook(RenameNotebook event, Emitter<NotesState> emit) async {
    assert(_currentNotebook?.id?.isNotEmpty == true);
    if (event.id.isNotEmpty && event.name.trim().isNotEmpty) {
      int result = await _notebookRepo.updateNotebook(event.id, event.name.trim());
      Log.d('Update notebook $result');
    }
  }

  void _deleteNotebook(DeleteNotebook event, Emitter<NotesState> emit) async {
    assert(_currentNotebook?.id?.isNotEmpty == true);
    if (event.id.isNotEmpty) {
      // todo: delete all children
      int result = await _notebookRepo.removeNotebook(event.id);
      Log.d('Delete notebook $result');
    }
  }

  void _addNote(AddNote event, Emitter<NotesState> emit) async {
    assert(_currentNotebook?.id?.isNotEmpty == true);
    String noteId = await _noteRepo.addNote(_currentNotebook?.id ?? '', '', '');
    Log.d('Insert note $noteId');
    if (noteId.isNotEmpty) {
      emit(NoteAdded(noteId));
    }
  }

  void _renameNote(RenameNote event, Emitter<NotesState> emit) async {
    assert(_currentNotebook?.id?.isNotEmpty == true);
    if (event.id.isNotEmpty && event.name.trim().isNotEmpty) {
      int result = await _noteRepo.updateTitle(event.id, event.name.trim());
      Log.d(' Update note $result');
    }
  }

  void _deleteNote(DeleteNote event, Emitter<NotesState> emit) async {
    assert(_currentNotebook?.id?.isNotEmpty == true);
    if (event.id.isNotEmpty) {
      int result = await _noteRepo.removeNote(event.id);
      Log.d('Delete note $result');
    }
  }

  void _publish(PublishNotes event, Emitter<NotesState> emit) {
    emit(NotesLoaded(
      _currentNotebook?.id ?? '',
      _currentNotebook?.title ?? '',
      List.of((_latestNotes ?? List.empty()) + (_latestNotebooks ?? List.empty())),
    ));
  }

  @override
  Future<void> close() {
    _notebookSub?.cancel();
    _noteSub?.cancel();
    return super.close();
  }
}
