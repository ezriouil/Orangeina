part of 'profile_cubit.dart';

@immutable
sealed class ProfileState {}

final class ProfileCurrentState extends ProfileState {}

final class ProfileLoadingState extends ProfileState {}

final class ProfileErrorState extends ProfileState {
  final String message;
  ProfileErrorState({required this.message});
}
