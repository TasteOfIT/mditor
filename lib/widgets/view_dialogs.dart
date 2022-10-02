import 'package:flutter/material.dart';

enum ViewDialogsAction {
  yes,
  no;
}

class ViewDialogs {
  static Future<ViewDialogsAction> simpleDialog(
    BuildContext context,
    String title,
    String body, {
    bool barrierDismissible = true,
    bool useRootNavigator = true,
  }) async {
    final action = await showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      useRootNavigator: useRootNavigator,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(title),
          content: Text(body),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(ViewDialogsAction.no),
              child: Text(MaterialLocalizations.of(context).cancelButtonLabel),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(ViewDialogsAction.yes),
              child: Text(MaterialLocalizations.of(context).okButtonLabel),
            ),
          ],
        );
      },
    );
    return (action != null) ? action : ViewDialogsAction.no;
  }

  static Future<String> editorDialog(
    BuildContext context,
    String title, {
    String editorHint = '',
    String initialText = '',
    bool barrierDismissible = true,
    bool useRootNavigator = true,
  }) async {
    final result = await showDialog<String>(
      context: context,
      barrierDismissible: barrierDismissible,
      useRootNavigator: useRootNavigator,
      builder: (BuildContext context) {
        TextEditingController controller = TextEditingController();
        controller.text = initialText;
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(title),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              hintText: editorHint,
            ),
            autofocus: true,
            keyboardType: TextInputType.name,
            maxLength: 24,
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(''),
              child: Text(MaterialLocalizations.of(context).cancelButtonLabel),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(controller.value.text),
              child: Text(MaterialLocalizations.of(context).okButtonLabel),
            ),
          ],
        );
      },
    );
    return (result != null) ? result : '';
  }
}
