part of 'settings_cubit.dart';

@immutable
sealed class SettingsState {}

final class SettingsCurrentState extends SettingsState {}

final class SettingsLoadingState extends SettingsState {}

final class SettingsErrorState extends SettingsState {
  final String message;
  SettingsErrorState({required this.message});
}
