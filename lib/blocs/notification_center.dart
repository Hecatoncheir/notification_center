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
        _controlPanelReadyController.add(true);
      } else {
        _controlPanelReadyController.add(true);
        _notificationsController.add(history);
      }
    });

    _controlPanelReadyController = StreamController<bool>();
    controlPanelReady = _controlPanelReadyController.stream;
  }

  StreamController<NotificationModel> notifications;

  StreamController<List<NotificationModel>> _notificationsController;
  Stream<List<NotificationModel>> notificationsForShow;

  void dispose() {
    notifications.close();
    _notificationsController.close();
    _controlPanelReadyController.close();
  }

  void getAllNotifications() {
    _notificationsController.add(history);
    _controlPanelReadyController.add(true);
  }

  void closeAllNotifications() {
    _notificationsController.add([]);
    _controlPanelReadyController.add(false);
  }

  StreamController<bool> _controlPanelReadyController;
  Stream<bool> controlPanelReady;
}
