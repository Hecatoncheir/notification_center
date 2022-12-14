import 'dart:async';

import '../notification_center.dart';
import 'interface.dart';

/// NotificationBase - model with data for notification.
class NotificationBase implements Notification {
  String header;
  String body;

  NotificationBuilder<NotificationBase>? builder;
  Future<dynamic>? closeAfter;

  NotificationBase({
    required this.header,
    required this.body,
    this.builder,
    Future<dynamic>? closeAfter,
  }) : this.closeAfter = closeAfter;
}
