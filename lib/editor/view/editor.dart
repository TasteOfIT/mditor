import 'package:data/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../app/app.dart';
import '../../design/theme.dart';
import '../../home/bloc/working_cubit.dart';
import '../../l10n/wording.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/file_dialogs.dart';
import '../bloc/note_content_bloc.dart';

class Editor extends StatefulWidget {
  const Editor({Key? key, this.noteId = '', this.onChanged}) : super(key: key);

  final String noteId;
  final ValueChanged? onChanged;

  @override
  State<StatefulWidget> createState() {
    return _EditorState();
  }
}

class _EditorState extends State<Editor> {
  final TextEditingController _controller = TextEditingController();
  late NoteRepository _noteRepository;
  late NoteContentBloc _noteContentBloc;
  late String _noteId;
  late String _title;

  String get body => _controller.value.text;

  @override
  void initState() {
    super.initState();
    _noteRepository = RepositoryProvider.of<NoteRepository>(context);
    _noteContentBloc = NoteContentBloc(_noteRepository);
    _controller
      ..text = ''
      ..addListener(() {
        widget.onChanged?.call(body);
      });
    _noteId = widget.noteId;
    _title = '';
    _noteContentBloc.add(LoadNoteContent(_noteId));
  }

  void _preview() {
    Routes.add(Routes.routeViewer, args: Doc(title: _title, content: body));
  }

  void _openFolder() {
    Routes.open(Routes.routeNotes);
  }

  void _openDrawer() {
    context.read<AppDrawerCubit>().openDrawer();
  }

  void _rename() async {
    await FileDialogs.renameNote(context, _title, (name) {
      _noteContentBloc.add(ChangeNoteTitle(_noteId, name));
    });
  }

  void _delete() async {
    await FileDialogs.deleteFile(context, _title, () {
      _noteContentBloc.add(DeleteNote(_noteId));
    });
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
        return Scaffold(
          appBar: AppBarBuilder.withDrawer(
            context,
            _formatTitle(),
            _openDrawer,
            actions: [
              ActionData(Icons.preview, _preview),
              ActionData(Icons.edit_outlined, _rename),
              ActionData(Icons.delete_outline_rounded, _delete, color: Theme.of(context).errorColor),
            ],
          ),
          body: TextField(
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              hintText: S.of(context).inputHint,
            ),
            maxLines: 99999,
            scrollPadding: const EdgeInsets.all(20.0),
            keyboardType: TextInputType.multiline,
            autofocus: true,
            controller: _controller,
          ),
        );
      },
    );
  }

  void _updateNote(NoteContentState state) {
    if (state is NoteContentLoaded) {
      setState(() {
        _title = state.title;
        _controller.text = state.body;
      });
    } else if (state is NoteTitleChanged) {
      setState(() {
        _title = state.title;
      });
    } else if (state is NoteBodyChanged) {
      setState(() {
        _controller.text = state.body;
      });
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
  void dispose() {
    _controller.dispose();
    _noteContentBloc.close();
    super.dispose();
  }
}
