// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(name) => "Do you want to delete \"${name}\"?";

  static String m1(name) => "Hi, I am ${name}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "addNote": MessageLookupByLibrary.simpleMessage("New note"),
        "addNoteHint": MessageLookupByLibrary.simpleMessage(
            "Click the floating button in the lower right corner to create your first note"),
        "addNotebook": MessageLookupByLibrary.simpleMessage("New notebook"),
        "addNotebookHint": MessageLookupByLibrary.simpleMessage(
            "Open drawer on the left to create or select a notebook"),
        "appName": MessageLookupByLibrary.simpleMessage("Mditor"),
        "delete": MessageLookupByLibrary.simpleMessage("Delete"),
        "deleteConfirmMessage": m0,
        "edit": MessageLookupByLibrary.simpleMessage("Edit"),
        "editNotebook": MessageLookupByLibrary.simpleMessage("Edit notebook"),
        "hello": m1,
        "home": MessageLookupByLibrary.simpleMessage("Welcome"),
        "inputHint": MessageLookupByLibrary.simpleMessage("Start here"),
        "moveTo": MessageLookupByLibrary.simpleMessage("Move to notebook"),
        "nameInputHint": MessageLookupByLibrary.simpleMessage("Untitled"),
        "noNotebooks": MessageLookupByLibrary.simpleMessage("No notebooks"),
        "notebooks": MessageLookupByLibrary.simpleMessage("Notebooks"),
        "rename": MessageLookupByLibrary.simpleMessage("Rename"),
        "renameNote": MessageLookupByLibrary.simpleMessage("Rename note"),
        "settings": MessageLookupByLibrary.simpleMessage("Settings"),
        "view": MessageLookupByLibrary.simpleMessage("View")
      };
}
