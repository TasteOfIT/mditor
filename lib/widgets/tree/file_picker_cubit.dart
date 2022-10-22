import 'package:bloc/bloc.dart';
import 'package:flutter_treeview/flutter_treeview.dart';

class FilePickerCubit extends Cubit<TreeViewController> {
  FilePickerCubit(super.initialState) : super();

  void set(List<Node> files) => emit(TreeViewController(children: files));

  void select(String key) => emit(state.copyWith(selectedKey: key));

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
