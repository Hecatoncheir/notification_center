import 'package:flutter/widgets.dart' hide Notification;

class NotificationBuilder<T> {
  Type type;

  Widget Function(T notification) headerBuilder;
  Widget Function(T notification) bodyBuilder;

  NotificationBuilder({
    required this.headerBuilder,
    required this.bodyBuilder,
  }) : type = T;
}
