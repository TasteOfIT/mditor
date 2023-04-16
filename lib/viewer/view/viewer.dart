import 'package:common/widgets.dart';
import 'package:data/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:markdown_viewer/markdown_viewer.dart';

import '../../app/app.dart';

class Viewer extends StatefulWidget {
  const Viewer({Key? key, this.noteId = ''}) : super(key: key);

  final String noteId;

  @override
  State<StatefulWidget> createState() {
    return _ViewerState();
  }
}

class _ViewerState extends State<Viewer> {
  late NoteRepository _noteRepository;
  late ViewDocBloc _viewDocBloc;
  String _title = '';

  Future<Doc?> _loadNote(String noteId) {
    return _noteRepository.getNote(noteId).timeout(const Duration(seconds: 5), onTimeout: () => null).then((note) {
      if (note != null) {
        return Doc(title: note.title, content: note.body);
      } else {
        return null;
      }
    });
  }

  void _updateTitle(String title) {
    setState(() {
      _title = title;
    });
  }

  @override
  void initState() {
    super.initState();
    _noteRepository = RepositoryProvider.of<NoteRepository>(context);
    _viewDocBloc = ViewDocBloc(_loadNote);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarBuilder.get(
        _title,
        [ActionData(Icons.edit_outlined, _editNote)],
      ),
      body: BlocProvider<ViewDocBloc>(
        create: (context) => _viewDocBloc,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: MarkdownViewer(widget.noteId, _viewDocBloc, _updateTitle),
        ),
      ),
    );
  }

  void _editNote() {
    Routes.pop();
  }
}
