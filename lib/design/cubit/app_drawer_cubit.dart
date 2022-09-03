import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class AppDrawerCubit extends Cubit<bool> {
  AppDrawerCubit(this.scaffoldState)
      : assert(scaffoldState.hasDrawer),
        super(scaffoldState.isDrawerOpen);

  final ScaffoldState scaffoldState;

  void openDrawer() {
    scaffoldState.openDrawer();
    emit(scaffoldState.isDrawerOpen);
  }

  void closeDrawer() {
    scaffoldState.closeDrawer();
    emit(scaffoldState.isDrawerOpen);
  }
}
