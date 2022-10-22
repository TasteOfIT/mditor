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

class PublishNotes extends NotesEvent {
  const PublishNotes() : super();

  @override
  List<Object?> get props => [];
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

class MoveNote extends NotesEvent {
  final String id;
  final String parentId;

  const MoveNote(this.id, this.parentId);

  @override
  List<Object?> get props => [id, parentId];
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

class MoveNotebook extends NotesEvent {
  final String id;
  final String parentId;

  const MoveNotebook(this.id, this.parentId);

  @override
  List<Object?> get props => [id, parentId];
}

class DeleteNotebook extends NotesEvent {
  final String id;

  const DeleteNotebook(this.id) : super();

  @override
  List<Object?> get props => [id];
}
