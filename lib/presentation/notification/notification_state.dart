part of 'notification_cubit.dart';

@immutable
sealed class NotificationState {}

final class NotificationMainState extends NotificationState {
  final List<NotificationEntity>? notifications;

  NotificationMainState({ this.notifications });

  NotificationMainState copyWith({ List<NotificationEntity>? notifications}) => NotificationMainState(notifications: notifications ?? this.notifications);
}

final class NotificationLoadingState extends NotificationState {}

final class NotificationErrorState extends NotificationState {
  final String message;
  NotificationErrorState({required this.message});
}

final class NotificationEmptyState extends NotificationState {}