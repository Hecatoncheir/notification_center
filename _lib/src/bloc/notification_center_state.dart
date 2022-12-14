part of 'notification_center_bloc.dart';

@immutable
abstract class NotificationCenterState {}

class NotificationCenterInitial extends NotificationCenterState {}

class NotificationsReadyForRender extends NotificationCenterState {
  final List<NotificationWithBuilder> notificationsForRender;
  final List<NotificationWithBuilder> allNotifications;

  NotificationsReadyForRender({
    required this.notificationsForRender,
    required this.allNotifications,
  });
}
