part of 'notification_center_bloc.dart';

@immutable
abstract class NotificationCenterState {}

class NotificationCenterInitial extends NotificationCenterState {}

class NotificationsReadyForRender extends NotificationCenterState {
  final List<NotificationWithGroup> notificationsForRender;
  NotificationsReadyForRender({required this.notificationsForRender});
}
