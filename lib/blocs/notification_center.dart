import 'dart:async';

import 'package:notification_center/models/notification.dart'
    show NotificationModel;

class NotificationCenterBloc {
  final List<NotificationModel> history = [];

  /// Constructor
  NotificationCenterBloc() {
    _notificationsController = StreamController<List<NotificationModel>>();
    notificationsForShow = _notificationsController.stream;

    notifications = StreamController<NotificationModel>();
    notifications.stream.listen((notification) {
      history.add(notification);
      if (notification.onlyOneNotificationShow) {
        _notificationsController.add([notification]);
      } else {
        _notificationsController.add(history);
      }
    });
  }

  StreamController<NotificationModel> notifications;

  StreamController<List<NotificationModel>> _notificationsController;
  Stream<List<NotificationModel>> notificationsForShow;

  void dispose() {
    notifications.close();
    _notificationsController.close();
  }

  void getAllNotifications() => _notificationsController.add(history);
  void closeAllNotifications() => _notificationsController.add([]);
}
