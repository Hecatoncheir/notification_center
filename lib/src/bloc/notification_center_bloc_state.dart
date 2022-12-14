part of 'notification_center_bloc.dart';

@immutable
abstract class NotificationCenterBlocState {
  const NotificationCenterBlocState();
}

class AllNotifications extends NotificationCenterBlocState {
  final List<Notification> notifications;
  const AllNotifications({required this.notifications});
}

class NotificationDeletedSuccessful extends NotificationCenterBlocEvent {
  final Notification notification;
  const NotificationDeletedSuccessful({required this.notification});
}

class ShowAllNotificationsBegin extends NotificationCenterBlocState {
  final List<Notification> notifications;
  const ShowAllNotificationsBegin({required this.notifications});
}

class ShowAllNotificationsEnd extends NotificationCenterBlocState {
  const ShowAllNotificationsEnd();
}

class ShowNotificationBegin extends NotificationCenterBlocState {
  final Notification notification;
  const ShowNotificationBegin({required this.notification});
}

class ShowNotificationEnd extends NotificationCenterBlocState {
  final Notification notification;
  const ShowNotificationEnd({required this.notification});
}
