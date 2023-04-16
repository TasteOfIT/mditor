import 'package:flutter/cupertino.dart';

import '../../locale/locale.dart';
import '../../widgets/view_dialogs.dart';

class FileDialogs {
  static Future<void> addNotebook(BuildContext context, void Function(String) onAction) async {
    String name = await ViewDialogs.editorDialog(
      context,
      S.of(context).addNotebook,
      editorHint: S.of(context).nameInputHint,
    );
    if (name.trim().isNotEmpty) {
      onAction(name);
    }
  }

  static Future<void> renameNotebook(BuildContext context, String label, void Function(String) onAction) async {
    String name = await ViewDialogs.editorDialog(
      context,
      S.of(context).editNotebook,
      editorHint: S.of(context).nameInputHint,
      initialText: label,
    );
    if (name.trim().isNotEmpty && name.trim() != label.trim()) {
      onAction(name);
    }
  }

  static Future<void> renameNote(BuildContext context, String label, void Function(String) onAction) async {
    String name = await ViewDialogs.editorDialog(
      context,
      S.of(context).renameNote,
      editorHint: S.of(context).nameInputHint,
      initialText: label,
    );
    if (name.trim().isNotEmpty && name.trim() != label.trim()) {
      onAction(name);
    }
  }

  static Future<void> deleteFile(BuildContext context, String label, void Function() onAction) async {
    ViewDialogsAction result = await ViewDialogs.simpleDialog(
      context,
      S.of(context).delete,
      S.of(context).deleteConfirmMessage(label),
    );
    if (result == ViewDialogsAction.yes) {
      onAction();
    }
  }
}
