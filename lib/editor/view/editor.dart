import 'dart:async';

import 'package:common/common.dart';
import 'package:data/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:markdown_editor/markdown_editor.dart';

import '../../app/app.dart';
import '../../files/files.dart';
import '../../locale/locale.dart';
import '../../widgets/app_bar.dart';
import '../bloc/note_content_bloc.dart';

class Editor extends StatefulWidget {
  const Editor({Key? key, this.noteId = ''}) : super(key: key);

  final String noteId;

  @override
  State<StatefulWidget> createState() {
    return _EditorState();
  }
}

class _EditorState extends State<Editor> {
  late Controller _controller;
  late NoteRepository _noteRepository;
  late NoteContentBloc _noteContentBloc;
  late String _noteId;
  late String _title;

  late Timer _autoSaveTimer;

  String get body => _controller.data;

  @override
  void initState() {
    super.initState();
    _noteRepository = RepositoryProvider.of<NoteRepository>(context);
    _noteContentBloc = NoteContentBloc(_noteRepository);
    _controller = Controller(widget.noteId, '');
    _noteId = widget.noteId;
    _title = '';
    _noteContentBloc.add(LoadNoteContent(_noteId));
    _autoSaveTimer = Timer.periodic(const Duration(seconds: 15), (timer) => _saveContent());
  }

  void _saveContent() {
    _noteContentBloc.add(ChangeNoteBody(_noteId, body));
  }

  void _preview() {
    _saveContent();
    Routes.add(Routes.routeViewer, args: _noteId);
  }

  void _openFolder() {
    Routes.open(Routes.routeNotes);
  }

  void _rename() async {
    await FileDialogs.renameNote(context, _title, (name) {
      _noteContentBloc.add(ChangeNoteTitle(_noteId, name));
    });
  }

  void _delete() async {
    await FileDialogs.deleteFile(context, _formatTitle(), () {
      _noteContentBloc.add(DeleteNote(_noteId));
    });
  }

  void _deleteNoConfirmation() async {
    _noteContentBloc.add(DeleteNote(_noteId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NoteContentBloc>(
      create: (_) => _noteContentBloc,
      child: BlocListener<WorkingCubit, WorkingState>(
        listener: (context, state) {
          if (state.noteId != null) {
            _noteId = state.noteId ?? '';
            _noteContentBloc.add(LoadNoteContent(_noteId));
          } else {
            _openFolder();
          }
        },
        child: _editor(),
      ),
    );
  }

  Widget _editor() {
    return BlocConsumer<NoteContentBloc, NoteContentState>(
      listener: (context, state) {
        _updateNote(state);
      },
      builder: (context, state) {
        return FilesDrawerScaffold(
          SimpleEditor(S.of(context).inputHint, _controller),
          appBar: AppBarBuilder.get(
            _formatTitle(),
            [
              ActionData(Icons.preview, _preview),
              ActionData(Icons.edit_outlined, _rename),
              ActionData(Icons.delete_outline_rounded, _delete, color: Theme.of(context).errorColor),
            ],
          ),
        );
      },
    );
  }

  void _updateNote(NoteContentState state) {
    if (state is NoteContentLoaded) {
      setState(() {
        _title = state.title;
        _controller.data = state.body;
      });
    } else if (state is NoteTitleChanged) {
      setState(() {
        _title = state.title;
      });
    } else if (state is NoteBodyChanged) {
      // ignore, data was saved from here
    } else if (state is NoteDeleted) {
      _openFolder();
    }
  }

  String _formatTitle() {
    String title = _title;
    if (title.isEmpty) {
      title = S.of(context).nameInputHint;
    }
    return title;
  }

  @override
  void deactivate() {
    if (body.isEmpty && _title.isEmpty) {
      Log.d('Delete since nothing input');
      _deleteNoConfirmation();
    } else {
      Log.d('Save when deactivate');
      _saveContent();
    }
    super.deactivate();
  }

  @override
  void dispose() {
    _autoSaveTimer.cancel();
    _noteContentBloc.close();
    _controller.dispose();
    super.dispose();
  }
}
