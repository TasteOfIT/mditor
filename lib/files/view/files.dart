import 'package:common/widgets.dart';
import 'package:flutter/material.dart';

import '../../app/app.dart';
import '../../locale/locale.dart';
import 'file_manager.dart';

class FilesDrawerScaffold extends StatelessWidget {
  const FilesDrawerScaffold(
    this.body, {
    Key? key,
    this.appBar,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.backgroundColor,
    this.onDrawerChanged,
  }) : super(key: key);

  final Widget body;
  final PreferredSizeWidget? appBar;
  final FloatingActionButton? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final DrawerCallback? onDrawerChanged;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: body,
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
      backgroundColor: backgroundColor,
      onDrawerChanged: onDrawerChanged,
      drawer: _FileDrawer(),
    );
  }
}

class _FileDrawer extends StatelessWidget {
  void _openSettings(BuildContext context) {
    Scaffold.of(context).closeDrawer();
    Routes.add(Routes.routeSettings);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            const Expanded(
              flex: 1,
              child: FileManager(),
            ),
            Dividers.horizontal(),
            IconTextMenu(
              icon: Icons.settings_applications,
              label: S.of(context).settings,
              onTap: () => _openSettings(context),
            ),
          ],
        ),
      ),
    );
  }
}
