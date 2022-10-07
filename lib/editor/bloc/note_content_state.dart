part of 'note_content_bloc.dart';

enum FileError {
  notFound,
  invalidData;
}

abstract class NoteContentState extends Equatable {
  const NoteContentState();
}

class NoteContentLoading extends NoteContentState {
  @override
  List<Object?> get props => [];
}

class NoteContentError extends NoteContentState {
  final FileError error;

  const NoteContentError(this.error) : super();

  @override
  List<Object?> get props => [error];
}

class NoteContentLoaded extends NoteContentState {
  final String id;
  final String title;
  final String body;

  const NoteContentLoaded(this.id, this.title, this.body) : super();

  @override
  List<Object?> get props => [id, title, body];
}

class NoteTitleChanged extends NoteContentState {
  final String id;
  final String title;

  const NoteTitleChanged(this.id, this.title) : super();

  @override
  List<Object?> get props => [id, title];
}

class NoteBodyChanged extends NoteContentState {
  final String id;
  final String body;

  const NoteBodyChanged(this.id, this.body) : super();

  @override
  List<Object?> get props => [id, body];
}

class NoteDeleted extends NoteContentState {
  final String id;

  const NoteDeleted(this.id) : super();

  @override
  List<Object?> get props => [id];
}
