part of 'forget_password_cubit.dart';

@immutable
sealed class ForgetPasswordState {}

final class ForgetPasswordMainState extends ForgetPasswordState {
  final TextEditingController? emailController;
  final GlobalKey<FormState>? formState;

  ForgetPasswordMainState({ this.emailController, this.formState });
}

final class ForgetPasswordLoadingState extends ForgetPasswordState {}