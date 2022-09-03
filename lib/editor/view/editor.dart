import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../app/app.dart';
import '../../design/theme.dart';
import '../../l10n/wording.dart';
import '../../widgets/app_bar.dart';

class Editor extends StatefulWidget {
  const Editor({Key? key, this.initialText = '', this.onChanged}) : super(key: key);

  final String initialText;
  final ValueChanged? onChanged;

  @override
  State<StatefulWidget> createState() {
    return _EditorState();
  }
}

class _EditorState extends State<Editor> {
  final TextEditingController _controller = TextEditingController();

  String get text => _controller.value.text;

  void _preview() {
    Routes.add(Routes.routeViewer, args: Doc(title: 'Preview', content: text));
  }

  void _openDrawer() {
    context.read<AppDrawerCubit>().openDrawer();
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
      appBar: AppBarBuilder.withDrawer(
        context,
        S.of(context).notebooks,
        _openDrawer,
        [ActionData(Icons.preview, _preview)],
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
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
