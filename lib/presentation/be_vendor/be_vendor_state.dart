part of 'be_vendor_cubit.dart';

@immutable
sealed class BeVendorState {}

final class BeVendorMainState extends BeVendorState {
  final ScrollPhysics? scrollPhysics;
  final int? currentStep;
  final String? gender, carType, shopThumbnail, cinFrontImage, cinBackImage, carAssuranceImage, carRegistrationImage;
  final TextEditingController? cinController, phoneController, ageController, carAssuranceController, carRegistrationController;
  final UserEntity? userEntity;
  final GlobalKey<FormState>? personalInfoFormState, carInfoFormState;

  BeVendorMainState(
      {this.scrollPhysics,
      this.currentStep,
      this.gender,
      this.carType,
      this.shopThumbnail,
      this.cinFrontImage,
      this.cinBackImage,
      this.carAssuranceImage,
      this.carRegistrationImage,
      this.cinController,
      this.phoneController,
      this.ageController,
      this.carAssuranceController,
      this.carRegistrationController,
      this.userEntity,
      this.personalInfoFormState,
      this.carInfoFormState,
      });

  BeVendorMainState copyWith(
          {ScrollPhysics? scrollPhysics,
          int? currentStep,
          String? gender,
          String? carType,
          String? shopThumbnail,
          String? cinFrontImage,
          String? cinBackImage,
          String? carAssuranceImage,
          String? carRegistrationImage,
          TextEditingController? cinController,
          TextEditingController? phoneController,
          TextEditingController? ageController,
          TextEditingController? carAssuranceController,
          TextEditingController? carRegistrationController,
          UserEntity? userEntity,
          GlobalKey<FormState>? personalInfoFormState,
          GlobalKey<FormState>? carInfoFormState,
          }) =>
      BeVendorMainState(
          scrollPhysics: scrollPhysics ?? this.scrollPhysics,
          currentStep: currentStep ?? this.currentStep,
        gender: gender ?? this.gender,
        carType: carType ?? this.carType,
        shopThumbnail: shopThumbnail ?? this.shopThumbnail,
        cinFrontImage: cinFrontImage ?? this.cinFrontImage,
        cinBackImage: cinBackImage ?? this.cinBackImage,
        carAssuranceImage: carAssuranceImage ?? this.carAssuranceImage,
        carRegistrationImage: carRegistrationImage ?? this.carRegistrationImage,
        cinController: cinController ?? this.cinController,
        phoneController: phoneController ?? this.phoneController,
          ageController: ageController ?? this.ageController,
        carAssuranceController: carAssuranceController ?? this.carAssuranceController,
        carRegistrationController: carRegistrationController ?? this.carRegistrationController,
        userEntity: userEntity ?? this.userEntity,
        personalInfoFormState: personalInfoFormState ?? this.personalInfoFormState,
        carInfoFormState: carInfoFormState ?? this.carInfoFormState,
  );

}

final class BeVendorLoadingState extends BeVendorState {}

final class BeVendorSuccessState extends BeVendorState {}
