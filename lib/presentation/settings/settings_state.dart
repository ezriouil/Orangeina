part of 'settings_cubit.dart';

@immutable
sealed class SettingsState {}

final class SettingsCurrentState extends SettingsState {

  final bool? enableDarkMode, hideAuthentication, arabicLang, frenchLang, englishLang;
  final TextEditingController? updateFirstNameController,
      updateLastNameController,
      updateEmailNameController,
      updatePasswordController,
      updatePhoneController;

  SettingsCurrentState(
      {this.enableDarkMode, this.hideAuthentication,
      this.arabicLang, this.frenchLang, this.englishLang,
      this.updateFirstNameController,
      this.updateLastNameController,
      this.updateEmailNameController,
      this.updatePasswordController,
      this.updatePhoneController});

  SettingsCurrentState copyWith(
          {bool? enableDarkMode,
          bool? hideAuthentication,
          bool? arabicLang,
          bool? frenchLang,
          bool? englishLang,
          TextEditingController? updateFirstNameController,
          TextEditingController? updateLastNameController,
          TextEditingController? updateEmailNameController,
          TextEditingController? updatePasswordController,
          TextEditingController? updatePhoneController}) =>

      SettingsCurrentState(
        enableDarkMode: enableDarkMode ?? this.enableDarkMode,
        hideAuthentication: hideAuthentication ?? this.hideAuthentication,
        arabicLang: arabicLang ?? this.arabicLang,
        frenchLang: frenchLang ?? this.frenchLang,
        englishLang: englishLang ?? this.englishLang,
        updateFirstNameController: updateFirstNameController ?? this.updateFirstNameController,
        updateLastNameController: updateLastNameController ?? this.updateLastNameController,
        updateEmailNameController: updateEmailNameController ?? this.updateEmailNameController,
        updatePasswordController: updatePasswordController ?? this.updatePasswordController,
        updatePhoneController: updatePhoneController ?? this.updatePhoneController,
      );

}

final class SettingsLoadingState extends SettingsState {}

final class SettingsErrorState extends SettingsState {
  final String message;
  SettingsErrorState({required this.message});
}
