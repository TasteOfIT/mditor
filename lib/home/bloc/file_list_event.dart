part of 'file_list_bloc.dart';

abstract class FileListEvent extends Equatable {
  const FileListEvent();
}

class FileListRefresh extends FileListEvent {
  @override
  List<Object?> get props => [];
}

class FileListLoaded extends FileListEvent {
  final List<Notebook> notebooks;
  final List<NoteItem> notes;

  const FileListLoaded(this.notebooks, this.notes);

  @override
  List<Object?> get props => [notebooks, notes];
}
