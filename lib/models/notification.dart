import 'interface.dart';

/// NotificationBase - model with data for notification.
class NotificationBase implements Notification {
  String header;
  String body;

  @override
  Duration? closeAfter;

  NotificationBase({
    required this.header,
    required this.body,
    this.closeAfter,
  });
}
