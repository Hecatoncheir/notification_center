library notification_center;

import 'package:flutter/material.dart';

import 'package:notification_center/models.dart' show NotificationModel;

import 'package:notification_center/blocs.dart' show NotificationCenterBloc;

import 'package:notification_center/widgets/notification.dart'
    show NotificationWidget;

/// NotificationCenterWidget  - widget for show notifications.
class NotificationCenterWidget extends StatelessWidget {
  /// NotificationCenterBloc - logic of notification show/hide, hold history.
  final NotificationCenterBloc notificationCenterBloc;

  /// child - main widget of application.
  final Widget? child;

  /// Constructor
  const NotificationCenterWidget({
    required this.notificationCenterBloc,
    this.child,
  });

  @override
  Widget build(BuildContext context) => buildLayout(context);

  Widget buildLayout(BuildContext context) {
    final _widget = child == null ? Container() : child!;

    return Stack(
      children: [
        _widget,
        StreamBuilder(
          stream: notificationCenterBloc.notificationsForShow,
          builder: (context, AsyncSnapshot<List<NotificationModel>> snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              final notifications = snapshot.data;
              if (notifications == null) return Container();

              return SingleChildScrollView(
                child: Column(
                  children: [
                    for (final notification in notifications)
                      _buildNotification(notification),
                  ],
                ),
              );
            } else {
              return Container();
            }
          },
        ),
      ],
    );
  }

  Widget _buildNotification(NotificationModel notification) => Dismissible(
        key: UniqueKey(),
        child: NotificationWidget(notification),
      );
}
