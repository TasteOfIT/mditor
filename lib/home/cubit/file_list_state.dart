part of 'file_list_bloc.dart';

abstract class FileListState extends Equatable {
  const FileListState();
}

class FileListData extends FileListState {
  final List<FileNode> nodes;

  const FileListData(this.nodes);

  @override
  List<Object> get props => [nodes];
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
