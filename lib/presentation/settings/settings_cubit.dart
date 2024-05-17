import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(SettingsCurrentState()){ init(); }

  // - - - - - - - - - - - - - - - - - - INIT - - - - - - - - - - - - - - - - - -  //
  void init() async{
    emit(SettingsCurrentState(enableDarkMode: false, enableMapSatellite: false, showMyLocationOnMap: false, hideAuthentication: false));
  }

  void onUpdateEnableDarkMode(bool value){
    final currentState = state as SettingsCurrentState;
    emit(currentState.copyWith(enableDarkMode: value));

  }

  void onUpdateEnableFullScreen(bool value){
    final currentState = state as SettingsCurrentState;
    emit(currentState.copyWith(showMyLocationOnMap: value));
  }

  void onUpdateEnableMapSatellite(bool value){
    final currentState = state as SettingsCurrentState;
    emit(currentState.copyWith(enableMapSatellite: value));
  }

}
