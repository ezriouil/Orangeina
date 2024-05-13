part of 'forget_password_cubit.dart';

@immutable
sealed class ForgetPasswordState {}

final class ForgetPasswordInitialState extends ForgetPasswordState {}

final class ForgetPasswordLoadingState extends ForgetPasswordState {}

final class ForgetPasswordSuccessState extends ForgetPasswordState {
  final UserCredential userCredential;

  ForgetPasswordSuccessState({ required this.userCredential });
}

final class ForgetPasswordErrorState extends ForgetPasswordState {
  final String message;

  ForgetPasswordErrorState({ required this.message });
}
