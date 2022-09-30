import 'package:flutter/material.dart';

class IconTextMenu extends StatelessWidget {
  const IconTextMenu({
    Key? key,
    required this.label,
    required this.icon,
    this.action,
    this.onTap,
    this.onAction,
  }) : super(key: key);

  final String label;
  final IconData icon;
  final IconData? action;
  final GestureTapCallback? onTap;
  final GestureTapCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      trailing: IconButton(
        icon: Icon(action, size: 26.0),
        onPressed: () => {onAction?.call()},
      ),
      title: Text(label),
      horizontalTitleGap: 8,
      onTap: onTap,
    );
  }
}
