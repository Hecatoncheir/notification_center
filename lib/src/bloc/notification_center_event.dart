part of 'notification_center_bloc.dart';

@immutable
abstract class NotificationCenterEvent {}

class NotificationAdded extends NotificationCenterEvent {
  final Notification notification;
  NotificationAdded({required this.notification});
}

class NotificationClosed extends NotificationCenterEvent {
  final Notification notification;
  NotificationClosed({required this.notification});
}

class NotificationsOpenAll extends NotificationCenterEvent {}

class NotificationsCloseAll extends NotificationCenterEvent {}
