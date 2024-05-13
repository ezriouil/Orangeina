part of 'login_cubit.dart';

@immutable
sealed class LoginState {}

final class LoginCurrentState extends LoginState {
  final TextEditingController?emailController, passwordController;
  final bool?  passwordVisible;
  final GlobalKey<FormState>? formState;

  LoginCurrentState({
        this.emailController,
        this.passwordController,
        this.passwordVisible,
        this.formState});

  LoginCurrentState copyWith({
    TextEditingController? emailController,
    TextEditingController? passwordController,
    bool? passwordVisible,
    GlobalKey<FormState>? formState,
  }) {
    return LoginCurrentState(
      emailController: emailController ?? this.emailController,
      passwordController: passwordController ?? this.passwordController,
      passwordVisible: passwordVisible ?? this.passwordVisible,
      formState: formState ?? this.formState,
    );
  }
}

final class LoginLoadingState extends LoginState {}

final class LoginErrorState extends LoginState {
  final String message;

  LoginErrorState({ required this.message });
}
