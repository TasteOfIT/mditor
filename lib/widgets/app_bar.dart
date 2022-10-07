import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'action_menu.dart';

class AppBarBuilder {
  static AppBar get(String title, List<ActionData> actions) {
    return AppBar(
      title: Text(title),
      actions: actions.map((action) {
        return ActionMenu(icon: action.icon, pressCallback: action.callback);
      }).toList(),
    );
  }

  static AppBar withDrawer(
    BuildContext context,
    String title,
    VoidCallback openDrawer, {
    List<ActionData> actions = const [],
  }) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.menu),
        onPressed: openDrawer,
        tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
      ),
      title: Text(title),
      actions: actions.map((action) {
        return ActionMenu(icon: action.icon, pressCallback: action.callback);
      }).toList(),
      automaticallyImplyLeading: false,
    );
  }
}

class ActionData extends Equatable {
  const ActionData(this.icon, this.callback);

  final IconData icon;
  final VoidCallback callback;

  @override
  List<Object?> get props => [icon, callback];
}
