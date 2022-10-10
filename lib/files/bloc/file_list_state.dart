part of 'file_list_bloc.dart';

abstract class FileListState extends Equatable {
  const FileListState();
}

class FileListLoaded extends FileListState {
  final List<File> notebooks;
  final List<File> notes;

  const FileListLoaded(this.notebooks, this.notes);

  @override
  List<Object> get props => [notebooks, notes];
}

//todo: add error handling
class FileLoadError extends FileListState {
  final String message;

  const FileLoadError(this.message);

  @override
  List<Object?> get props => [message];
}

class FileAdded extends FileListState {
  final String? parentId;
  final FileNode file;

  const FileAdded(this.file, {this.parentId});

  @override
  List<Object?> get props => [file.data, parentId];
}

class FileChanged extends FileListState {
  final String id;
  final FileNode file;

  const FileChanged(this.id, this.file);

  @override
  List<Object?> get props => [file.data, id];
}

class FileDeleted extends FileListState {
  final String id;
  final String? parentId;

  const FileDeleted(this.id, this.parentId);

  @override
  List<Object?> get props => [id, parentId];
}

//todo: add error handling
class FileOpError extends FileListState {
  final String message;

  const FileOpError(this.message);

  @override
  List<Object?> get props => [message];
}
