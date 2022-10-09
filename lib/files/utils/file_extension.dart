import 'package:data/data.dart';
import 'package:flutter_treeview/flutter_treeview.dart';

import '../../widgets/tree/file.dart';

const FileNode empty = Node(key: '', label: '');

Comparator<FileNode> nodeComparator = (left, right) {
  return (left.data?.createdTime ?? 0).compareTo(right.data?.createdTime ?? 0);
};

class FilesExt {
  static List<FileNode> of(List<File> notebooks, List<File> notes) {
    List<FileNode> allNodes = _fromNotebooks(notebooks) + _fromItems(notes);
    allNodes.sort(nodeComparator);

    List<FileNode> result = List.empty(growable: true);
    Map<String, List<FileNode>> children = {};
    for (var node in allNodes) {
      String parentKey = node.data?.parentId ?? empty.key;
      (children.putIfAbsent(parentKey, () => List.empty(growable: true))).add(node);
    }
    result.addAll(_wrapUpNodeTree(children));
    return result;
  }

  static List<FileNode> _fromItems(List<File> noteItems) {
    return noteItems.map((noteItem) {
      return toNode(noteItem, false);
    }).toList(growable: false);
  }

  static List<FileNode> _fromNotebooks(List<File> notebooks) {
    return notebooks.map((notebook) {
      return toNode(notebook, true);
    }).toList(growable: false);
  }

  static List<FileNode> _wrapUpNodeTree(Map<String, List<FileNode>> remnantNodes) {
    Map<String, List<FileNode>> currentLeaves = {};
    while (remnantNodes.isNotEmpty) {
      _moveNodesToLeaves(remnantNodes, currentLeaves);
    }
    return currentLeaves[empty.key] ?? List.empty();
  }

  static void _moveNodesToLeaves(Map<String, List<FileNode>> remnantNodes, Map<String, List<FileNode>> currentLeaves) {
    for (var key in remnantNodes.keys.toList(growable: false)) {
      var isParent = remnantNodes[key]?.any((note) => remnantNodes.containsKey(note.key)) ?? false;
      if (!isParent) {
        var leafNodes = remnantNodes.remove(key) ?? List.empty();
        leafNodes.sort(nodeComparator);
        _insertIntoLeaves(currentLeaves, key, leafNodes);
      }
    }
  }

  static void _insertIntoLeaves(Map<String, List<FileNode>> currentLeaves, String leafKey, List<FileNode> leafNodes) {
    currentLeaves[leafKey] = leafNodes.map((node) {
      List<FileNode>? children = currentLeaves.remove(node.key);
      if (children?.isNotEmpty == true) {
        return node.copyWith(children: children);
      } else {
        return node;
      }
    }).toList();
  }

  static List<File> fromItems(List<NoteItem> noteItems) {
    return noteItems.map(File.fromNoteItem).toList(growable: false);
  }

  static List<File> fromNotebooks(List<Notebook> notebooks) {
    return notebooks.map(File.fromNotebook).toList(growable: false);
  }

  static FileNode toNode(File file, bool parent) {
    return Node(
      key: file.id ?? '',
      label: file.label,
      data: file,
      parent: parent,
    );
  }
}
