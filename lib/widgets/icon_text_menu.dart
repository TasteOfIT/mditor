import 'package:flutter/material.dart';

class IconTextMenu extends StatelessWidget {
  const IconTextMenu({
    Key? key,
    required this.label,
    required this.icon,
    this.onTap,
  }) : super(key: key);

  final String label;
  final IconData icon;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(label),
      horizontalTitleGap: 8,
      onTap: onTap,
    );
  }
}
