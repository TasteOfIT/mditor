import 'package:flutter/material.dart';

import '../../app/routes.dart';
import '../../l10n/wording.dart';

class Editor extends StatefulWidget {
  const Editor({Key? key, this.initialText = '', this.onChanged}) : super(key: key);

  final String initialText;
  final ValueChanged? onChanged;

  GenerateAppTitle get onGenerateTitle => (context) => S.of(context).add;

  @override
  State<StatefulWidget> createState() {
    return _EditorState();
  }
}

class _EditorState extends State<Editor> {
  final TextEditingController _controller = TextEditingController();

  String get text => _controller.value.text;

  void _preview() {
    Navigator.pushNamed(context, Routes.routeViewer, arguments: Doc(title: 'Preview', content: text));
  }

  @override
  void initState() {
    super.initState();
    _controller
      ..text = widget.initialText
      ..addListener(() {
        widget.onChanged?.call(text);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.onGenerateTitle(context)),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: IconButton(
                onPressed: _preview,
                icon: const Icon(
                  Icons.preview,
                  size: 26.0,
                ),
              ),
            )
          ],
        ),
        body: TextField(
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Enter notes',
          ),
          maxLines: 99999,
          scrollPadding: const EdgeInsets.all(20.0),
          keyboardType: TextInputType.multiline,
          autofocus: true,
          controller: _controller,
        ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
