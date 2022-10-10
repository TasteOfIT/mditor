part of 'file_list_bloc.dart';

abstract class FileListEvent extends Equatable {
  const FileListEvent();
}

class LoadFileList extends FileListEvent {
  @override
  List<Object?> get props => [];
}

class AddNotebook extends FileListEvent {
  final String? parentId;
  final String name;

  const AddNotebook(this.name, {this.parentId});

  @override
  List<Object?> get props => [name, parentId];
}

class RenameNotebook extends FileListEvent {
  final String id;
  final String name;

  const RenameNotebook(this.id, this.name);

  @override
  List<Object?> get props => [name, id];
}

class DeleteNotebook extends FileListEvent {
  final String id;
  final String? parentId;

  const DeleteNotebook(this.id, this.parentId);

  @override
  List<Object?> get props => [id, parentId];
}

class AddNote extends FileListEvent {
  final String parentId;

  const AddNote(this.parentId);

  @override
  List<Object?> get props => [parentId];
}

class RenameNote extends FileListEvent {
  final String id;
  final String name;

  const RenameNote(this.id, this.name);

  @override
  List<Object?> get props => [name, id];
}

class DeleteNote extends FileListEvent {
  final String id;
  final String parentId;

  const DeleteNote(this.id, this.parentId);

  @override
  List<Object?> get props => [id, parentId];
}
