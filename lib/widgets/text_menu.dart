import 'package:flutter/material.dart';

class TextMenu extends StatelessWidget {
  const TextMenu({
    Key? key,
    required this.label,
    this.onTap,
  }) : super(key: key);

  final String label;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(label),
      horizontalTitleGap: 8,
      onTap: onTap,
    );
  }
}
