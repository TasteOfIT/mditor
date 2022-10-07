part of 'notes_bloc.dart';

abstract class NotesEvent extends Equatable {
  const NotesEvent();
}

class LoadNotes extends NotesEvent {
  final String? id;

  const LoadNotes(this.id) : super();

  @override
  List<Object?> get props => [id];
}

class AddNote extends NotesEvent {
  final String id;

  const AddNote(this.id) : super();

  @override
  List<Object?> get props => [id];
}

class RenameNote extends NotesEvent {
  final String id;
  final String name;

  const RenameNote(this.id, this.name) : super();

  @override
  List<Object?> get props => [id, name];
}

class DeleteNote extends NotesEvent {
  final String id;

  const DeleteNote(this.id) : super();

  @override
  List<Object?> get props => [id];
}

class AddNotebook extends NotesEvent {
  final String id;
  final String name;

  const AddNotebook(this.id, this.name) : super();

  @override
  List<Object?> get props => [id, name];
}

class RenameNotebook extends NotesEvent {
  final String id;
  final String name;

  const RenameNotebook(this.id, this.name) : super();

  @override
  List<Object?> get props => [id, name];
}

class DeleteNotebook extends NotesEvent {
  final String id;

  const DeleteNotebook(this.id) : super();

  @override
  List<Object?> get props => [id];
}
