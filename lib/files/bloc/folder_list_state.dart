part of 'folder_list_bloc.dart';

abstract class FolderListState extends Equatable {
  const FolderListState();
}

class FolderListLoaded extends FolderListState {
  final List<File> notebooks;
  final String parentId;
  final String? selfId; // Only if folder

  const FolderListLoaded(this.notebooks, this.parentId, {this.selfId});

  @override
  List<Object?> get props => [notebooks, parentId, selfId];
}

//todo: add error handling
class FolderLoadError extends FolderListState {
  final String message;

  const FolderLoadError(this.message);

  @override
  List<Object?> get props => [message];
}
