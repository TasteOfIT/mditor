part of 'note_content_bloc.dart';

abstract class NoteContentEvent extends Equatable {
  const NoteContentEvent();
}

class LoadNoteContent extends NoteContentEvent {
  final String id;

  const LoadNoteContent(this.id) : super();

  @override
  List<Object?> get props => [id];
}

class ChangeNoteTitle extends NoteContentEvent {
  final String id;
  final String title;

  const ChangeNoteTitle(this.id, this.title) : super();

  @override
  List<Object?> get props => [id, title];
}

class ChangeNoteBody extends NoteContentEvent {
  final String id;
  final String body;

  const ChangeNoteBody(this.id, this.body) : super();

  @override
  List<Object?> get props => [id, body];
}
