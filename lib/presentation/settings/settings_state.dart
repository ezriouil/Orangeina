part of 'settings_cubit.dart';

@immutable
sealed class SettingsState {}

final class SettingsMainState extends SettingsState {

  final bool? arabicLang, frenchLang, englishLang, isVendor, vendorOnlineOffline;
  final String? updateImageProfilePath;

  SettingsMainState(
      {
      this.arabicLang,
      this.frenchLang,
      this.englishLang,
      this.isVendor = false,
      this.vendorOnlineOffline,
      this.updateImageProfilePath});

  SettingsMainState copyWith(
          {
          bool? arabicLang,
          bool? frenchLang,
          bool? englishLang,
          bool? isVendor,
          bool? vendorOnlineOffline,
          String? updateImageProfilePath}) =>

      SettingsMainState(
        arabicLang: arabicLang ?? this.arabicLang,
        frenchLang: frenchLang ?? this.frenchLang,
        englishLang: englishLang ?? this.englishLang,
        isVendor: isVendor ?? this.isVendor,
        vendorOnlineOffline: vendorOnlineOffline ?? this.vendorOnlineOffline,
        updateImageProfilePath: updateImageProfilePath ?? this.updateImageProfilePath
      );

}

final class SettingsLoadingState extends SettingsState {}

final class SettingsErrorState extends SettingsState {
  final String message;
  SettingsErrorState({required this.message});
}
