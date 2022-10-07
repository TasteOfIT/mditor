import 'package:data/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../app/app.dart';
import '../../design/theme.dart';
import '../../home/bloc/working_cubit.dart';
import '../../l10n/wording.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/file_dialogs.dart';
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
      await FileDialogs.addNotebook(context, (name) {
        _notesBloc.add(AddNotebook(parentId, name));
      });
    }
  }

  void _openDrawer() {
    context.read<AppDrawerCubit>().openDrawer();
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
    bool showEmpty = workingState.notebookId?.isNotEmpty != true;
    if (showEmpty) {
      return Scaffold(
        appBar: AppBarBuilder.withDrawer(
          context,
          S.of(context).home,
          _openDrawer,
        ),
        body: const Empty(),
        floatingActionButton: _floatingActionButton(context, !showEmpty),
      );
    }
    return BlocConsumer<NotesBloc, NotesState>(
      listener: (context, state) {
        if (state is NoteAdded) {
          Routes.open(Routes.routeEditor, args: state.id);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBarBuilder.withDrawer(context, _formatTitle(state), _openDrawer),
          body: _content(state),
          floatingActionButton: _floatingActionButton(context, !showEmpty),
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

  Widget? _floatingActionButton(BuildContext context, bool canAddNote) {
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
    }
    if (title.isEmpty) {
      title = S.of(context).nameInputHint;
    }
    return title;
  }
}