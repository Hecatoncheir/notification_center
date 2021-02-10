import 'package:flutter/widgets.dart' hide Notification;

class NotificationBuilder<T> {
  final Type type;

  final Function? headerBuilder;
  final Function? bodyBuilder;

  NotificationBuilder({
    Widget Function(T notification)? headerBuilder,
    Widget Function(T notification)? bodyBuilder,
  })  : this.type = T,
        this.headerBuilder = headerBuilder,
        this.bodyBuilder = bodyBuilder;
}
