import 'package:flutter/widgets.dart' hide Notification;
import 'notification.dart';

typedef NotificationBuilderType = Widget Function(Notification notification);

class NotificationBuilder<T> {
  Type type;

  NotificationBuilderType headerBuilder;
  NotificationBuilderType bodyBuilder;

  NotificationBuilder({
    required this.headerBuilder,
    required this.bodyBuilder,
  }) : type = T;
}
