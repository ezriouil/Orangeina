part of 'register_cubit.dart';

@immutable
sealed class RegisterState {}

final class RegisterCurrentState extends RegisterState {
  final TextEditingController? firstNameController,
      lastNameController,
      emailController,
      passwordController,
      confirmPasswordController;
  final bool? checkbox, obscureText;
  final GlobalKey<FormState>? formState;

  RegisterCurrentState(
      {this.firstNameController,
      this.lastNameController,
      this.emailController,
      this.passwordController,
      this.confirmPasswordController,
      this.checkbox,
      this.obscureText,
      this.formState});

  RegisterCurrentState copyWith({
    TextEditingController? firstNameController,
    TextEditingController? lastNameController,
    TextEditingController? emailController,
    TextEditingController? passwordController,
    TextEditingController? confirmPasswordController,
    bool? checkbox,
    bool? obscureText,
    GlobalKey<FormState>? formState,
  }) {
    return RegisterCurrentState(
      firstNameController: firstNameController ?? this.firstNameController,
      lastNameController: lastNameController ?? this.lastNameController,
      emailController: emailController ?? this.emailController,
      passwordController: passwordController ?? this.passwordController,
      confirmPasswordController: confirmPasswordController ?? this.confirmPasswordController,
      checkbox: checkbox ?? this.checkbox,
      obscureText: obscureText ?? this.obscureText,
      formState: formState ?? this.formState,
    );
  }
}

final class RegisterLoadingState extends RegisterState {}

final class RegisterErrorState extends RegisterState {
  final String message;
  RegisterErrorState({required this.message});
}
