import 'package:bloc/bloc.dart';
import 'package:data/data.dart';
import 'package:equatable/equatable.dart';

import '../../app/app.dart';

part 'note_content_event.dart';

part 'note_content_state.dart';

class NoteContentBloc extends Bloc<NoteContentEvent, NoteContentState> {
  final NoteRepository _noteRepo;

  NoteContentBloc(this._noteRepo) : super(NoteContentLoading()) {
    on<LoadNoteContent>(_loadNote);
    on<ChangeNoteTitle>(_titleChanged);
    on<ChangeNoteBody>(_bodyChanged);
    on<DeleteNote>(_deleteNote);
  }

  void _loadNote(LoadNoteContent event, Emitter<NoteContentState> emit) async {
    NoteItem? note = await _noteRepo.getNote(event.id);
    if (note == null) {
      emit(const NoteContentError(FileError.notFound));
    } else if (note.id == event.id && note.parentId.isNotEmpty == true) {
      emit(NoteContentLoaded(event.id, note.title ?? '', note.body ?? ''));
    } else {
      emit(const NoteContentError(FileError.invalidData));
    }
  }

  void _titleChanged(ChangeNoteTitle event, Emitter<NoteContentState> emit) async {
    int result = await _noteRepo.updateTitle(event.id, event.title);
    Log.d('Rename note $result');
    if (result == 1) {
      emit(NoteTitleChanged(event.id, event.title));
    }
  }

  void _bodyChanged(ChangeNoteBody event, Emitter<NoteContentState> emit) async {
    int result = await _noteRepo.updateContent(event.id, event.body);
    Log.d('Save note $result');
    if (result == 1) {
      emit(NoteBodyChanged(event.id, event.body));
    }
  }

  void _deleteNote(DeleteNote event, Emitter<NoteContentState> emit) async {
    int result = await _noteRepo.removeNote(event.id);
    Log.d('Delete note $result');
    if (result == 1) {
      emit(NoteDeleted(event.id));
    }
  }
}
