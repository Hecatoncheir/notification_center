library notification_center;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:notification_center/models/notification_group.dart';

import 'bloc/notification_center_bloc.dart';

/// NotificationCenter  - widget for show notifications.
class NotificationCenter extends StatelessWidget {
  /// NotificationCenterBloc - logic of notification show/hide, hold history.
  final NotificationCenterBloc notificationCenterBloc;

  /// child - main widget of application.
  final Widget? child;

  final List<NotificationGroup>? groups;

  /// Constructor
  const NotificationCenter({
    required this.notificationCenterBloc,
    this.groups,
    this.child,
  });

  @override
  Widget build(BuildContext context) => buildLayout(context);

  Widget buildLayout(BuildContext context) => Stack(
        children: [
          child == null ? Container() : child!,
          buildNotifications(context),
        ],
      );

  Widget buildNotifications(BuildContext context) =>
      BlocBuilder<NotificationCenterBloc, NotificationCenterState>(
        buildWhen: (previous, current) {
          if (current is NotificationsReadyForRender) return true;
          return false;
        },
        builder: (BuildContext context, state) => Container(
          child: SingleChildScrollView(
            child: Column(),
          ),
        ),
      );

  // Widget _buildNotification(NotificationModel notification) => Dismissible(
  //       key: UniqueKey(),
  //       child: NotificationWidget(notification),
  //     );
}
