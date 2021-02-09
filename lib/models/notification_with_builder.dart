import 'interface.dart';
import 'notification_builder.dart';

class NotificationWithBuilder {
  Notification notification;
  NotificationBuilder builder;

  NotificationWithBuilder({
    required this.notification,
    required this.builder,
  });
}
