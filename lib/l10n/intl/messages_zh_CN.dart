// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a zh_CN locale. All the
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
  String get localeName => 'zh_CN';

  static String m0(name) => "确定要删除\"${name}\"?";

  static String m1(name) => "嗨, 我是${name}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "addNote": MessageLookupByLibrary.simpleMessage("新建笔记"),
        "addNoteHint": MessageLookupByLibrary.simpleMessage("点击右下角按钮创建第一个笔记吧"),
        "addNotebook": MessageLookupByLibrary.simpleMessage("新建笔记本"),
        "addNotebookHint":
            MessageLookupByLibrary.simpleMessage("打开左侧菜单创建或选择一个笔记本"),
        "appName": MessageLookupByLibrary.simpleMessage("Mditor"),
        "delete": MessageLookupByLibrary.simpleMessage("删除"),
        "deleteConfirmMessage": m0,
        "edit": MessageLookupByLibrary.simpleMessage("编辑"),
        "editNotebook": MessageLookupByLibrary.simpleMessage("编辑笔记本"),
        "hello": m1,
        "home": MessageLookupByLibrary.simpleMessage("你好"),
        "inputHint": MessageLookupByLibrary.simpleMessage("从此开始"),
        "moveTo": MessageLookupByLibrary.simpleMessage("移动到笔记本"),
        "nameInputHint": MessageLookupByLibrary.simpleMessage("未命名笔记本"),
        "noNotebooks": MessageLookupByLibrary.simpleMessage("没有笔记本"),
        "notebooks": MessageLookupByLibrary.simpleMessage("所有笔记本"),
        "rename": MessageLookupByLibrary.simpleMessage("重命名"),
        "renameNote": MessageLookupByLibrary.simpleMessage("重命名笔记"),
        "settings": MessageLookupByLibrary.simpleMessage("设置"),
        "view": MessageLookupByLibrary.simpleMessage("查看")
      };
}
