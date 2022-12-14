import 'package:flutter/widgets.dart' hide Notification;
import 'package:notification_center/src/bloc/notification_center_bloc.dart';

class NotificationBuilder<T> {
  final Type type;

  final Function? headerBuilder;
  final Function? bodyBuilder;

  NotificationBuilder({
    Widget Function(NotificationCenterBloc bloc, T notification)? headerBuilder,
    Widget Function(NotificationCenterBloc bloc, T notification)? bodyBuilder,
  })  : this.type = T,
        this.headerBuilder = headerBuilder,
        this.bodyBuilder = bodyBuilder;
}
