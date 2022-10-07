import 'package:data/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../app/app.dart';
import '../../design/theme.dart';
import '../../home/bloc/working_cubit.dart';
import '../../l10n/wording.dart';
import '../../widgets/app_bar.dart';
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
        _showNote(state);
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBarBuilder.withDrawer(
            context,
            _formatTitle(),
            _openDrawer,
            actions: [ActionData(Icons.preview, _preview)],
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

  void _showNote(NoteContentState state) {
    if (state is NoteContentLoaded) {
      setState(() {
        _title = state.title;
        _controller.text = state.body;
      });
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
