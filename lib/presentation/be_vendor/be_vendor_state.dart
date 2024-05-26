part of 'be_vendor_cubit.dart';

@immutable
sealed class BeVendorState {}

final class BeVendorMainState extends BeVendorState {
  final ScrollPhysics? scrollPhysics;
  final int? currentStep;
  final String? gender, carType, shopThumbnail, cinImage, carAssuranceImage, carRegistrationImage;
  final TextEditingController? cinController, phoneController, birthdayController, carAssuranceController, carRegistrationController;

  BeVendorMainState(
      {this.scrollPhysics,
      this.currentStep,
      this.gender,
      this.carType,
      this.shopThumbnail,
      this.cinImage,
      this.carAssuranceImage,
      this.carRegistrationImage,
      this.cinController,
      this.phoneController,
      this.birthdayController,
      this.carAssuranceController,
      this.carRegistrationController});

  BeVendorMainState copyWith(
          {ScrollPhysics? scrollPhysics,
          int? currentStep,
          String? gender,
          String? carType,
          String? shopThumbnail,
          String? cinImage,
          String? carAssuranceImage,
          String? carRegistrationImage,
          TextEditingController? cinController,
          TextEditingController? phoneController,
          TextEditingController? birthdayController,
          TextEditingController? carAssuranceController,
          TextEditingController? carRegistrationController}) =>
      BeVendorMainState(
          scrollPhysics: scrollPhysics ?? this.scrollPhysics,
          currentStep: currentStep ?? this.currentStep,
        gender: gender ?? this.gender,
        carType: carType ?? this.carType,
        shopThumbnail: shopThumbnail ?? this.shopThumbnail,
        cinImage: cinImage ?? this.cinImage,
        carAssuranceImage: carAssuranceImage ?? this.carAssuranceImage,
        carRegistrationImage: carRegistrationImage ?? this.carRegistrationImage,
        cinController: cinController ?? this.cinController,
        phoneController: phoneController ?? this.phoneController,
        birthdayController: birthdayController ?? this.birthdayController,
        carAssuranceController: carAssuranceController ?? this.carAssuranceController,
        carRegistrationController: carRegistrationController ?? this.carRegistrationController
  );

}

final class BeVendorLoadingState extends BeVendorState {}

final class BeVendorErrorState extends BeVendorState {}
