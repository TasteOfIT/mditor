import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../design/cubit/theme_mode_cubit.dart';
import '../../../l10n/wording.dart';
import '../settings_item.dart';

class General extends StatefulWidget {
  const General({super.key});

  @override
  State<StatefulWidget> createState() {
    return _GeneralState();
  }
}

class _GeneralState extends State<General> {
  late ThemeModeCubit _themeModeCubit;
  late ThemeMode _themeMode;

  @override
  void initState() {
    super.initState();
    _themeModeCubit = context.read<ThemeModeCubit>();
    _themeMode = _themeModeCubit.state;
  }

  void _changeTheme(ThemeMode? theme) {
    setState(() {
      _themeMode = theme ?? ThemeMode.system;
    });
  }

  void _saveTheme() {
    _themeModeCubit.set(_themeMode);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SettingsItem.category(context, S.of(context).settingsGeneral),
        SettingsItem.spaceVertical(4),
        SettingsItem.dropdownMenu<ThemeMode>(
          context,
          S.of(context).themeMenuLabel,
          _themeMode,
          _getThemeList(context),
          _changeTheme,
        ),
        SettingsItem.categoryButton(
          context,
          _saveTheme,
          primaryLabel: S.of(context).buttonLabelApply,
        ),
      ],
    );
  }

  List<DropdownMenuData<ThemeMode>> _getThemeList(BuildContext context) => [
        DropdownMenuData(ThemeMode.system, S.of(context).themeFollowSystem),
        DropdownMenuData(ThemeMode.light, S.of(context).themeLight),
        DropdownMenuData(ThemeMode.dark, S.of(context).themeDark),
      ];
}
