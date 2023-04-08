import 'package:flutter/material.dart';
import 'package:markdown_viewer/widgets/markdown_viewer.dart';

import '../../app/app.dart';
import '../../widgets/app_bar.dart';
import '../models/doc.dart';

class Viewer extends StatefulWidget {
  const Viewer({Key? key, this.title = '', this.content = ''}) : super(key: key);

  final String title;
  final String content;

  @override
  State<StatefulWidget> createState() {
    return _ViewerState();
  }
}

class _ViewerState extends State<Viewer> {
  @override
  Widget build(BuildContext context) {
    final doc = Routes.getData() as Doc?;
    return Scaffold(
      appBar: AppBarBuilder.get(
        doc == null ? widget.title : doc.title,
        [ActionData(Icons.edit_outlined, _editNote)],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: MarkdownViewer(content: doc == null ? widget.content : doc.content),
      ),
    );
  }

  void _editNote() {
    Routes.pop();
  }
}
