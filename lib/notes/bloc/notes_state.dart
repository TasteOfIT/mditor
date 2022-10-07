part of 'notes_bloc.dart';

abstract class NotesState extends Equatable {
  const NotesState();
}

class NotesInitial extends NotesState {
  @override
  List<Object> get props => [];
}

class NotesLoaded extends NotesState {
  final String id;
  final String name;
  final List<File> files;

  const NotesLoaded(this.id, this.name, this.files) : super();

  @override
  List<Object?> get props => [id, name, files];
}
