import 'package:data/data.dart';
import 'package:flutter_treeview/flutter_treeview.dart';
import 'package:json_annotation/json_annotation.dart';

part 'file.g.dart';

@JsonSerializable()
class File {
  File(
    this.id,
    this.label,
    this.createdTime,
    this.updatedTime,
    this.parentId,
    this.icon,
  );

  final String? id;
  final String label;
  final int createdTime;
  final int updatedTime;
  final String parentId;
  final String icon;

  static File fromNotebook(Notebook notebook) {
    return File(
      notebook.id,
      notebook.title,
      notebook.createdTime,
      notebook.updatedTime,
      notebook.parentId,
      notebook.icon,
    );
  }

  static File fromNoteItem(NoteItem noteItem) {
    return File(
      noteItem.id,
      noteItem.title,
      noteItem.createdTime,
      noteItem.updatedTime,
      noteItem.parentId,
      '',
    );
  }

  // Have to add this due to Node.toString()
  Map<String, dynamic> toJson() {
    return _$FileToJson(this);
  }
}

typedef FileNode = Node<File>;
