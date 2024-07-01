part of 'settings_cubit.dart';

@immutable
sealed class SettingsState {}

final class SettingsMainState extends SettingsState {

  final bool? arabicLang, frenchLang, englishLang, isVendor, vendorOnlineOffline;
  final String? updateImageProfilePath, firstNameHint, lastNameHint, phoneHint;

  SettingsMainState(
      {
      this.arabicLang,
      this.frenchLang,
      this.englishLang,
      this.isVendor = false,
      this.vendorOnlineOffline,
      this.updateImageProfilePath,
      this.firstNameHint,
      this.lastNameHint,
      this.phoneHint,
      });

  SettingsMainState copyWith(
          {
          bool? arabicLang,
          bool? frenchLang,
          bool? englishLang,
          bool? isVendor,
          bool? vendorOnlineOffline,
          String? updateImageProfilePath,
          String? firstNameHint,
          String? lastNameHint,
          String? phoneHint,
          }) =>

      SettingsMainState(
        arabicLang: arabicLang ?? this.arabicLang,
        frenchLang: frenchLang ?? this.frenchLang,
        englishLang: englishLang ?? this.englishLang,
        isVendor: isVendor ?? this.isVendor,
        vendorOnlineOffline: vendorOnlineOffline ?? this.vendorOnlineOffline,
        updateImageProfilePath: updateImageProfilePath ?? this.updateImageProfilePath,
        firstNameHint: firstNameHint ?? this.firstNameHint,
        lastNameHint: lastNameHint ?? this.lastNameHint,
        phoneHint: phoneHint ?? this.phoneHint,
      );
}

final class SettingsLoadingState extends SettingsState {}

final class SettingsErrorState extends SettingsState {
  final String message;
  SettingsErrorState({required this.message});
}
