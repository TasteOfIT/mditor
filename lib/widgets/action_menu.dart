import 'package:flutter/material.dart';

class ActionMenu extends StatelessWidget {
  const ActionMenu({Key? key, required this.icon, required this.pressCallback, this.color}) : super(key: key);

  final IconData icon;
  final VoidCallback pressCallback;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: IconButton(
        onPressed: pressCallback,
        icon: Icon(
          icon,
          color: color,
          size: 26.0,
        ),
      ),
    );
  }
}
