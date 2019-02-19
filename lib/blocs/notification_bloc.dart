import 'dart:async';
import 'package:notification_center/models.dart' show NotificationModel;

class NotificationCenterBloc {
  List<NotificationModel> history = <NotificationModel>[];

  StreamController<NotificationModel> notificationsController =
      StreamController<NotificationModel>();

  Stream<NotificationModel> notifications;

  NotificationCenterBloc() {
    notifications = notificationsController.stream;
  }

  void dispose() => notificationsController.close();
}
