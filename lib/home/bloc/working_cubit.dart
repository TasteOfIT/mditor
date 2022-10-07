import 'package:bloc/bloc.dart';

import 'working_state.dart';

export 'working_state.dart';

class WorkingCubit extends Cubit<WorkingState> {
  WorkingCubit() : super(const WorkingState());

  void cd(String? notebookId) => emit(state.cd(notebookId));

  void open(String? noteId) => emit(state.open(noteId));

  void goTo(String? notebookId) => emit(state.goTo(notebookId));
}
