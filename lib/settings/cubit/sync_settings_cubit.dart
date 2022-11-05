import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../model/sync_settings.dart';

class SyncSettingsCubit extends HydratedCubit<SyncSettings> {
  SyncSettingsCubit() : super(const SyncSettings());

  void update(SyncSettings settings) => emit(settings);

  @override
  SyncSettings fromJson(Map<String, dynamic> json) {
    return SyncSettings.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson(SyncSettings state) {
    return state.toJson();
  }
}
