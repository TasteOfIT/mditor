import 'package:common/widgets.dart';
import 'package:data/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../app/app.dart';
import '../../files/files.dart';
import '../../locale/locale.dart';
import '../bloc/notes_bloc.dart';
import 'empty.dart';
import 'note_list.dart';

class Notes extends StatefulWidget {
  const Notes({Key? key, this.notebookId}) : super(key: key);

  final String? notebookId;

  @override
  State<Notes> createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  late NotebookRepository _notebookRepository;
  late NoteRepository _noteRepository;
  late NotesBloc _notesBloc;

  @override
  void initState() {
    super.initState();
    _notebookRepository = RepositoryProvider.of<NotebookRepository>(context);
    _noteRepository = RepositoryProvider.of<NoteRepository>(context);
    _notesBloc = NotesBloc(_notebookRepository, _noteRepository);
    _loadNotes(widget.notebookId);
  }

  void _loadNotes(String? notebookId) {
    if (notebookId?.isNotEmpty == true) {
      _notesBloc.add(LoadNotes(notebookId));
    } else {
      _notesBloc.add(LoadNotes(context.read<WorkingCubit>().state.notebookId));
    }
  }

  void _addNote() async {
    String? parentId = context.read<WorkingCubit>().state.notebookId;
    if (parentId != null && parentId.isNotEmpty == true) {
      _notesBloc.add(AddNote(parentId));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NotesBloc>(
      create: (_) => _notesBloc,
      child: BlocConsumer<WorkingCubit, WorkingState>(
        listener: (context, state) {
          _loadNotes(state.notebookId);
        },
        builder: (context, state) {
          return _container(state);
        },
      ),
    );
  }

  Widget _container(WorkingState workingState) {
    return BlocConsumer<NotesBloc, NotesState>(
      listener: (context, state) {
        if (state is NoteAdded) {
          Routes.open(Routes.routeEditor, args: state.id);
        }
      },
      builder: (context, state) {
        bool showEmpty = workingState.notebookId?.isNotEmpty == false;
        if (showEmpty || state is! NotesLoaded) {
          return FilesDrawerScaffold(
            const Empty(),
            appBar: AppBarBuilder.get(S.of(context).home, const []),
            floatingActionButton: _floatingActionButton(context, false),
          );
        }
        return FilesDrawerScaffold(
          _content(state),
          appBar: AppBarBuilder.get(_formatTitle(state), const []),
          floatingActionButton: _floatingActionButton(context, true),
        );
      },
    );
  }

  Widget _content(NotesState state) {
    if (state is NotesLoaded) {
      if (state.files.isEmpty) {
        return const Empty(notebookSelected: true);
      } else {
        return NotesList(state.files, _notesBloc);
      }
    } else {
      return const Empty();
    }
  }

  FloatingActionButton? _floatingActionButton(BuildContext context, bool canAddNote) {
    if (canAddNote) {
      return FloatingActionButton(
        onPressed: _addNote,
        tooltip: S.of(context).addNote,
        child: const Icon(Icons.add),
      );
    } else {
      return null;
    }
  }

  String _formatTitle(NotesState state) {
    String title = '';
    if (state is NotesLoaded) {
      title = state.name;
      if (title.isEmpty) {
        title = S.of(context).nameInputHint;
      }
    }
    return title;
  }
}
