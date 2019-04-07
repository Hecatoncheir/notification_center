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
      _notificationsCountController.add(history.length);
      if (notification.onlyOneNotificationShow) {
        _notificationsController.add([notification]);
      } else {
        _notificationsController.add(history);
      }
    });

    _notificationsCountController = StreamController<int>();
    notificationsCount = _notificationsCountController.stream;
  }

  StreamController<int> _notificationsCountController;
  Stream<int> notificationsCount;

  StreamController<NotificationModel> notifications;

  StreamController<List<NotificationModel>> _notificationsController;
  Stream<List<NotificationModel>> notificationsForShow;

  void dispose() {
    notifications.close();
    _notificationsController.close();
    _notificationsCountController.close();
  }

  void getAllNotifications() {
    _notificationsController.add(history);
  }

  void closeAllNotifications() {
    _notificationsController.add([]);
  }
}
