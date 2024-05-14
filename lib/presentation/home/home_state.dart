part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeCurrentState extends HomeState {}

final class HomeLoadingState extends HomeState {}

final class HomeErrorState extends HomeState {
  final String message;
  HomeErrorState({required this.message});
}
