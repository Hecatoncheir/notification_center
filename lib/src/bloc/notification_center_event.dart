part of 'notification_center_bloc.dart';

@immutable
abstract class NotificationCenterEvent {}

class NotificationAdded extends NotificationCenterEvent {
  final Notification notification;
  NotificationAdded({required this.notification});
}
