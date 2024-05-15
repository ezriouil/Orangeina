part of 'notification_cubit.dart';

@immutable
sealed class NotificationState {}

final class NotificationCurrentState extends NotificationState {}

final class NotificationLoadingState extends NotificationState {}

final class NotificationErrorState extends NotificationState {
  final String message;
  NotificationErrorState({required this.message});
}
