import 'package:flutter/widgets.dart';

typedef Builder = Widget Function(Notification);

class NotificationGroup<T> {
  Type type;

  Builder headerBuilder;
  Builder bodyBuilder;

  NotificationGroup({
    required this.headerBuilder,
    required this.bodyBuilder,
  }) : type = T;
}
