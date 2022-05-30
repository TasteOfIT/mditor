import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:markdown/markdown.dart' hide Text;

import '../../app/routes.dart';

class Viewer extends StatelessWidget {
  const Viewer({Key? key, this.title = '', this.content = ''}) : super(key: key);

  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    final doc = ModalRoute.of(context)!.settings.arguments as Doc?;
    return Scaffold(
        appBar: AppBar(
          title: Text(doc == null ? title : doc.title),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.preview,
                  size: 26.0,
                ),
              ),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: HtmlWidget(
            markdownToHtml(doc == null ? content : doc.content),
            textStyle: const TextStyle(fontSize: 14),
          ),
        ));
  }
}
