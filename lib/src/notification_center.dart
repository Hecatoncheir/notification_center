library notification_center;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:notification_center/models/notification_with_builder.dart';

import 'bloc/notification_center_bloc.dart';

/// NotificationCenter  - widget for show notifications.
class NotificationCenter extends StatelessWidget {
  /// child - main widget of application.
  final Widget? child;

  final NotificationCenterBloc notificationCenterBloc;

  final Alignment alignment;
  final EdgeInsets padding;

  /// Constructor
  const NotificationCenter({
    required this.notificationCenterBloc,
    this.child,
    this.alignment = Alignment.topCenter,
    this.padding = EdgeInsets.zero,
  });

  @override
  Widget build(BuildContext context) => buildLayout(context);

  Widget buildLayout(BuildContext context) =>
      BlocProvider<NotificationCenterBloc>.value(
        value: notificationCenterBloc,
        child: Builder(
          builder: (context) => Stack(
            alignment: alignment,
            children: [
              child == null ? Container() : child!,
              buildNotifications(context)
            ],
          ),
        ),
      );

  Widget buildNotifications(BuildContext context) =>
      BlocBuilder<NotificationCenterBloc, NotificationCenterState>(
        buildWhen: (previous, current) {
          if (current is NotificationsReadyForRender) return true;
          return false;
        },
        builder: (BuildContext context, state) {
          if (state is NotificationsReadyForRender) {
            final notificationsForRender = state.notificationsForRender;

            CrossAxisAlignment alignment = CrossAxisAlignment.center;

            if (this.alignment == Alignment.topRight ||
                this.alignment == Alignment.bottomRight) {
              alignment = CrossAxisAlignment.start;
            }

            if (this.alignment == Alignment.topRight ||
                this.alignment == Alignment.bottomRight) {
              alignment = CrossAxisAlignment.end;
            }

            return Container(
              padding: padding,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: alignment,
                  children: [
                    for (final notification in notificationsForRender)
                      buildNotification(context, notification),
                  ],
                ),
              ),
            );
          }
          return Container();
        },
      );

  Widget buildNotification(
    BuildContext context,
    NotificationWithBuilder notification,
  ) =>
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              notification.builder.headerBuilder == null
                  ? Container()
                  : notification.builder.headerBuilder!(
                      notificationCenterBloc,
                      notification.notification,
                    ),
              notification.builder.bodyBuilder == null
                  ? Container()
                  : notification.builder.bodyBuilder!(
                      notificationCenterBloc,
                      notification.notification,
                    ),
            ],
          ),
        ],
      );
}
