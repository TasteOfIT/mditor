part of 'folder_list_bloc.dart';

abstract class FolderListEvent extends Equatable {
  const FolderListEvent();
}

class LoadFoldersList extends FolderListEvent {
  final String id;

  const LoadFoldersList(this.id);

  @override
  List<Object?> get props => [id];
}
