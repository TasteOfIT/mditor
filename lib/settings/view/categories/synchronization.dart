import 'package:flutter/material.dart' hide Interval;
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../locale/locale.dart';
import '../../cubit/sync_settings_cubit.dart';
import '../../model/sync_settings.dart';
import '../settings_item.dart';

class Synchronization extends StatefulWidget {
  const Synchronization({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SynchronizationState();
  }
}

class _SynchronizationState extends State<Synchronization> {
  late SyncSettingsCubit _syncSettingsCubit;
  late TextEditingController _urlController;
  late TextEditingController _emailController;
  late TextEditingController _pwdController;
  late Interval _syncInterval;

  @override
  void initState() {
    super.initState();
    _syncSettingsCubit = context.read<SyncSettingsCubit>();
    SyncSettings settings = _syncSettingsCubit.state;
    _urlController = TextEditingController(text: settings.serverUrl);
    _emailController = TextEditingController(text: settings.email);
    _pwdController = TextEditingController(text: settings.password);
    _syncInterval = settings.interval;
  }

  void _saveSettings() async {
    SyncSettings settings = SyncSettings(
      serverUrl: _urlController.value.text,
      email: _emailController.value.text,
      password: _pwdController.value.text,
      interval: _syncInterval,
    );
    _syncSettingsCubit.update(settings);
  }

  void _resetSettings() {
    setState(() {
      SyncSettings settings = _syncSettingsCubit.state;
      _urlController.text = settings.serverUrl;
      _emailController.text = settings.email;
      _pwdController.text = settings.password;
      _syncInterval = settings.interval;
    });
  }

  void _changeInterval(Interval? interval) {
    setState(() {
      _syncInterval = interval ?? Interval.disable;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SettingsItem.category(context, S.of(context).settingsSync),
        SettingsItem.spaceVertical(4),
        SettingsItem.editor(
          context,
          _urlController,
          S.of(context).syncServerUrlLabel,
          inputType: TextInputType.url,
          hint: 'http://docker.local:22300',
        ),
        SettingsItem.editor(
          context,
          _emailController,
          S.of(context).syncServerEmailLabel,
          inputType: TextInputType.emailAddress,
          hint: 'user@localhost',
        ),
        SettingsItem.editor(
          context,
          _pwdController,
          S.of(context).syncServerPasswordLabel,
          isSecret: true,
          inputType: TextInputType.visiblePassword,
        ),
        SettingsItem.dropdownMenu(
          context,
          S.of(context).syncInterval,
          _syncInterval,
          _intervalOptions(context),
          _changeInterval,
        ),
        SettingsItem.categoryButtons(
          context,
          _saveSettings,
          primaryLabel: S.of(context).buttonLabelApply,
          secondaryLabel: S.of(context).buttonLabelDiscard,
          onSecondaryAction: _resetSettings,
        ),
      ],
    );
  }

  List<DropdownMenuData<Interval>> _intervalOptions(BuildContext context) => [
        DropdownMenuData(Interval.disable, S.of(context).syncDisabled),
        DropdownMenuData(Interval.fiveMinutes, S.of(context).syncIntervalMinutes(5)),
        DropdownMenuData(Interval.tenMinutes, S.of(context).syncIntervalMinutes(10)),
        DropdownMenuData(Interval.halfHour, S.of(context).syncIntervalMinutes(30)),
        DropdownMenuData(Interval.oneHour, S.of(context).syncIntervalHours(1)),
        DropdownMenuData(Interval.twelveHours, S.of(context).syncIntervalHours(12)),
        DropdownMenuData(Interval.oneDay, S.of(context).syncIntervalDays(1)),
      ];
}
