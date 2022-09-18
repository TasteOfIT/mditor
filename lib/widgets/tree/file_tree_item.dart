import 'package:flutter/material.dart';

import 'file.dart';

class FileTreeItem extends StatelessWidget {
  const FileTreeItem({Key? key, required this.node, this.onLeadingPressed, this.onTrailingPressed}) : super(key: key);

  final FileNode node;
  final VoidCallback? onLeadingPressed;
  final VoidCallback? onTrailingPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _leadingIcon(context),
        Expanded(
          flex: 1,
          child: Text(
            node.label,
            maxLines: 1,
            style: const TextStyle(
              fontSize: 14,
              letterSpacing: 0.3,
              overflow: TextOverflow.clip,
            ),
          ),
        ),
        IconButton(
          onPressed: () => {onTrailingPressed?.call()},
          icon: const Icon(
            Icons.add_circle,
            size: 20,
          ),
          padding: const EdgeInsets.all(2),
        ),
      ],
    );
  }

  Widget _leadingIcon(BuildContext context) {
    IconData leading = Icons.lightbulb_circle_rounded;
    if (node.isParent) {
      if (node.expanded) {
        leading = Icons.arrow_circle_up_rounded;
      } else {
        leading = Icons.arrow_circle_down_rounded;
      }
    }
    return Center(
        widthFactor: 2.0,
        child: Padding(
          padding: EdgeInsets.only(left: node.isParent ? 0 : 1), // Workaround for flutter_treeview to align icons
          child: Icon(
            leading,
            size: 20,
          ),
        ));
  }
}
