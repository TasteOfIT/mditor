import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class ThemeModeCubit extends HydratedCubit<ThemeMode> {
  ThemeModeCubit() : super(ThemeMode.system);

  void enableLight() {
    emit(ThemeMode.light);
  }

  void enableDark() {
    emit(ThemeMode.dark);
  }

  void followSystem() {
    emit(ThemeMode.system);
  }

  @override
  ThemeMode fromJson(Map<String, dynamic> json) {
    return ThemeMode.values[json['theme'] as int];
  }

  @override
  Map<String, dynamic> toJson(ThemeMode state) {
    return <String, int>{'theme': state.index};
  }
}
