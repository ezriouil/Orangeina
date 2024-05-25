part of 'login_cubit.dart';

@immutable
sealed class LoginState {}

final class LoginMainState extends LoginState {
  final TextEditingController?emailController, passwordController;
  final bool?  obscureText, arabicLang, frenchLang, englishLang;
  final GlobalKey<FormState>? formState;

  LoginMainState({
        this.emailController,
        this.passwordController,
        this.obscureText,
        this.arabicLang,
        this.frenchLang,
        this.englishLang,
        this.formState});

  LoginMainState copyWith({
    TextEditingController? emailController,
    TextEditingController? passwordController,
    bool? obscureText,
    bool? arabicLang,
    bool? frenchLang,
    bool? englishLang,
    GlobalKey<FormState>? formState,
  }) {
    return LoginMainState(
      emailController: emailController ?? this.emailController,
      passwordController: passwordController ?? this.passwordController,
      obscureText: obscureText ?? this.obscureText,
      arabicLang: arabicLang ?? this.arabicLang,
      frenchLang: frenchLang ?? this.frenchLang,
      englishLang: englishLang ?? this.englishLang,
      formState: formState ?? this.formState,
    );
  }
}

final class LoginLoadingState extends LoginState {}

final class LoginErrorState extends LoginState {
  final String message;

  LoginErrorState({ required this.message });
}
