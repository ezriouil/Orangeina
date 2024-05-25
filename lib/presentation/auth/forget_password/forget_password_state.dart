part of 'forget_password_cubit.dart';

@immutable
sealed class ForgetPasswordState {}

final class ForgetPasswordMainState extends ForgetPasswordState {
  final TextEditingController? emailController;

  ForgetPasswordMainState({ this.emailController });
}

final class ForgetPasswordLoadingState extends ForgetPasswordState {}

final class ForgetPasswordErrorState extends ForgetPasswordState {
  final String message;

  ForgetPasswordErrorState({ required this.message });
}
