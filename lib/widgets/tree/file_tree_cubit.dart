import 'package:flutter_treeview/flutter_treeview.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import 'file.dart';

class FileTreeCubit extends Cubit<TreeViewController> {
  FileTreeCubit(super.initialState) : super();

  void set(List<Node> files) => emit(TreeViewController(children: files));

  void addToRoot(FileNode node) {
    List<FileNode> newChildren = List.from(state.children, growable: true);
    newChildren.add(node);
    emit(state.copyWith(children: newChildren));
  }

  void add(String parentKey, FileNode node) => emit(state.withAddNode(parentKey, node));

  void delete(String key) => emit(state.withDeleteNode(key));

  void update(FileNode node) {
    Node? currentNode = state.getNode(node.key);
    if (currentNode != null) {
      Node newNode = node.copyWith(children: currentNode.children);
      emit(state.withUpdateNode(newNode.key, newNode));
    }
  }

  void expand(String key, bool expanded) {
    Node? node = state.getNode(key);
    if (node != null) {
      emit(state.withUpdateNode(key, node.copyWith(expanded: expanded)));
    }
  }

  void toggle(String key) => emit(state.withToggleNode(key));

  void expandTo(String key) => emit(state.withExpandToNode(key));

  void collapseTo(String key) => emit(state.withCollapseToNode(key));

  void expandAll(String key) {
    Node? node = state.getNode(key);
    emit(state.withExpandAll(parent: node));
  }

  void collapseAll(String key) {
    Node? node = state.getNode(key);
    emit(state.withCollapseAll(parent: node));
  }
}
