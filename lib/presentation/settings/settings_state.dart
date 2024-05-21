part of 'settings_cubit.dart';

@immutable
sealed class SettingsState {}

final class SettingsCurrentState extends SettingsState {

  final bool? arabicLang, frenchLang, englishLang, isVendor, vendorOnlineOffline;
  final String? updateImageProfilePath;
  final TextEditingController? updateFirstNameController,
      updateLastNameController,
      updatePhoneController;

  SettingsCurrentState(
      {
      this.arabicLang,
      this.frenchLang,
      this.englishLang,
      this.isVendor = false,
      this.vendorOnlineOffline,
      this.updateImageProfilePath,
      this.updateFirstNameController,
      this.updateLastNameController,
      this.updatePhoneController});

  SettingsCurrentState copyWith(
          {
          bool? arabicLang,
          bool? frenchLang,
          bool? englishLang,
          bool? isVendor,
          bool? vendorOnlineOffline,
          String? updateImageProfilePath,
            TextEditingController? updateFirstNameController,
          TextEditingController? updateLastNameController,
          TextEditingController? updatePhoneController}) =>

      SettingsCurrentState(
        arabicLang: arabicLang ?? this.arabicLang,
        frenchLang: frenchLang ?? this.frenchLang,
        englishLang: englishLang ?? this.englishLang,
        isVendor: isVendor ?? this.isVendor,
        vendorOnlineOffline: vendorOnlineOffline ?? this.vendorOnlineOffline,
        updateImageProfilePath: updateImageProfilePath ?? this.updateImageProfilePath,
        updateFirstNameController: updateFirstNameController ?? this.updateFirstNameController,
        updateLastNameController: updateLastNameController ?? this.updateLastNameController,
        updatePhoneController: updatePhoneController ?? this.updatePhoneController,
      );

}

final class SettingsLoadingState extends SettingsState {}

final class SettingsErrorState extends SettingsState {
  final String message;
  SettingsErrorState({required this.message});
}
