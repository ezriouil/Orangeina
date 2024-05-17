part of 'settings_cubit.dart';

@immutable
sealed class SettingsState {}

final class SettingsCurrentState extends SettingsState {
  final bool? enableDarkMode,enableMapSatellite, showMyLocationOnMap, hideAuthentication;
  SettingsCurrentState({ this.enableDarkMode, this.showMyLocationOnMap, this.enableMapSatellite, this.hideAuthentication});

  SettingsCurrentState copyWith({ bool? enableDarkMode, bool? enableMapSatellite, bool? showMyLocationOnMap, bool? hideAuthentication}) =>
      SettingsCurrentState(
          enableDarkMode: enableDarkMode ?? this.enableDarkMode,
          showMyLocationOnMap: showMyLocationOnMap ?? this.showMyLocationOnMap,
          enableMapSatellite: enableMapSatellite ?? this.enableMapSatellite,
          hideAuthentication: hideAuthentication ?? this.hideAuthentication);
}

final class SettingsLoadingState extends SettingsState {}

final class SettingsErrorState extends SettingsState {
  final String message;
  SettingsErrorState({required this.message});
}
