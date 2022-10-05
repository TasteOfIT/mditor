import 'package:equatable/equatable.dart';

class WorkingState extends Equatable {
  const WorkingState({this.notebookId, this.noteId});

  final String? notebookId;
  final String? noteId;

  WorkingState cd(String? notebook) => WorkingState(
        notebookId: notebook,
        noteId: noteId,
      );

  WorkingState open(String? note) => WorkingState(
        notebookId: notebookId,
        noteId: note,
      );

  @override
  List<Object?> get props => [notebookId, noteId];
}
