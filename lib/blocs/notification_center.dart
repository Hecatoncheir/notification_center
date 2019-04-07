import 'dart:async';

import 'package:notofication_center/models/notification.dart'
    show NotificationModel;

class NotificationCenterBloc {
  final List<NotificationModel> history = [];

  /// Constructor
  NotificationCenterBloc() {
    _notificationsController = StreamController<NotificationModel>();
    allNotifications = _notificationsController.stream;

    notifications = StreamController<NotificationModel>();
    notifications.stream.listen((notification) {
      history.add(notification);
      _notificationsController.add(notification);
    });
  }

  StreamController<NotificationModel> notifications;
  Stream<NotificationModel> allNotifications;

  StreamController<NotificationModel> _notificationsController;

  void dispose() {
    notifications.close();
    _notificationsController.close();
  }
}
