import 'dart:async';

import 'package:meta/meta.dart';
import 'package:notification_center/notification_center.dart';
import 'package:notification_center/src/notifications/notification.dart';

part 'notification_center_bloc_event.dart';
part 'notification_center_bloc_interface.dart';
part 'notification_center_bloc_state.dart';

class NotificationCenterBloc implements NotificationCenterBlocInterface {
  final List<Notification> _notifications;

  late final StreamController<NotificationCenterBlocState> _stateController;
  late final Stream<NotificationCenterBlocState> _state;

  late final StreamController<NotificationCenterBlocEvent> _eventController;
  late final Stream<NotificationCenterBlocEvent> _event;
  late final StreamSubscription<NotificationCenterBlocEvent> _eventSubscription;

  NotificationCenterBloc() : _notifications = [] {
    _stateController = StreamController<NotificationCenterBlocState>();
    _state = _stateController.stream.asBroadcastStream();

    _eventController = StreamController<NotificationCenterBlocEvent>();
    _event = _eventController.stream;
    _eventSubscription = _event.listen((event) {
      if (event is GetAllNotifications) {
        _getAllNotificationsEventHandler(event);
      }
      if (event is ShowAllNotifications) {
        _showAllNotificationsEventHandler(event);
      }
      if (event is HideAllNotifications) {
        _hideAllNotificationsEventHandler(event);
      }
      if (event is ShowNotification) {
        _showNotificationEventHandler(event);
      }
      if (event is HideNotification) {
        _hideNotificationEventHandler(event);
      }
      if (event is NotificationDeleted) {
        _notificationDeletedEventHandler(event);
      }
    });
  }

  @override
  StreamController<NotificationCenterBlocEvent> controller() =>
      _eventController;

  @override
  Stream<NotificationCenterBlocState> stream() => _state;

  @override
  void dispose() {
    _stateController.close();

    _eventController.close();
    _eventSubscription.cancel();
  }

  Future<void> _getAllNotificationsEventHandler(GetAllNotifications _) async {
    _stateController.add(AllNotifications(notifications: _notifications));
  }

  Future<void> _showAllNotificationsEventHandler(ShowAllNotifications _) async {
    _stateController
        .add(ShowAllNotificationsBegin(notifications: _notifications));
  }

  Future<void> _hideAllNotificationsEventHandler(HideAllNotifications _) async {
    _stateController.add(const ShowAllNotificationsEnd());
  }

  Future<void> _showNotificationEventHandler(ShowNotification event) async {
    final notification = event.notification;
    _notifications.add(notification);
    _stateController.add(ShowNotificationBegin(notification: notification));

    Future.delayed(
      notification.displayDuration,
      () =>
          _stateController.add(ShowNotificationEnd(notification: notification)),
    );
  }

  Future<void> _hideNotificationEventHandler(HideNotification event) async {
    final notification = event.notification;
    _stateController.add(ShowNotificationEnd(notification: notification));
  }

  Future<void> _notificationDeletedEventHandler(
    NotificationDeleted event,
  ) async {
    final notification = event.notification;
    _notifications.remove(notification);
    _stateController.add(NotificationDeletedSuccessful(
      notification: notification,
      notifications: _notifications,
    ));
  }
}
