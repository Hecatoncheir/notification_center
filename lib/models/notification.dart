import 'dart:async';

import 'interface.dart';

/// NotificationBase - model with data for notification.
class NotificationBase implements Notification {
  String header;
  String body;

  Duration? closeAfter;
  Future? waitBeforeClose;

  NotificationBase({
    required this.header,
    required this.body,
    this.closeAfter,
    this.waitBeforeClose,
  });
}
