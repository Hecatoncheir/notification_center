part of 'notification_center_bloc.dart';

@immutable
abstract class NotificationCenterBlocEvent {
  const NotificationCenterBlocEvent();
}

class GetAllNotifications extends NotificationCenterBlocEvent {
  const GetAllNotifications();
}

class NotificationDeleted extends NotificationCenterBlocEvent {
  final Notification notification;
  const NotificationDeleted({required this.notification});
}

class ShowAllNotifications extends NotificationCenterBlocEvent {
  const ShowAllNotifications();
}

class HideAllNotifications extends NotificationCenterBlocEvent {
  const HideAllNotifications();
}

class ShowNotification extends NotificationCenterBlocEvent {
  final Notification notification;
  const ShowNotification({required this.notification});
}

class HideNotification extends NotificationCenterBlocEvent {
  final Notification notification;
  const HideNotification({required this.notification});
}
