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
}

class ActionData extends Equatable {
  const ActionData(this.icon, this.callback, {this.color});

  final IconData icon;
  final Color? color;
  final VoidCallback callback;

  @override
  List<Object?> get props => [icon, color, callback];
}
