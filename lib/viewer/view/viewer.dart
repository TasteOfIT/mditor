import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:markdown/markdown.dart' hide Text;

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
        padding: const EdgeInsets.only(right: 16.0),
        child: HtmlWidget(
          markdownToHtml(doc == null ? widget.content : doc.content),
          textStyle: const TextStyle(fontSize: 14),
        ),
      ),
    );
  }

  void _editNote() {
    Routes.pop();
  }
}
