part of 'file_list_bloc.dart';

abstract class FileListState extends Equatable {
  const FileListState();
}

class FileListData extends FileListState {
  final List<File> notebooks;
  final List<File> notes;

  const FileListData(this.notebooks, this.notes);

  @override
  List<Object> get props => [notebooks, notes];
}

class FileListLoading extends FileListState {
  @override
  List<Object?> get props => [];
}

class FileListError extends FileListState {
  final String message;

  const FileListError(this.message);

  @override
  List<Object?> get props => [message];
}
