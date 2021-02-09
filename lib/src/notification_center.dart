library notification_center;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:notification_center/models/notification_builder.dart';
import 'package:notification_center/models/notification_with_builder.dart';

import 'bloc/notification_center_bloc.dart';

/// NotificationCenter  - widget for show notifications.
class NotificationCenter extends StatelessWidget {
  final List<NotificationBuilder> builders;

  /// child - main widget of application.
  final Widget? child;

  final NotificationCenterBloc? notificationCenterBloc;

  final Alignment alignment;

  /// Constructor
  const NotificationCenter({
    required this.builders,
    this.child,
    this.notificationCenterBloc,
    this.alignment = Alignment.topCenter,
  });

  @override
  Widget build(BuildContext context) => buildLayout(context);

  Widget buildLayout(BuildContext context) => notificationCenterBloc == null
      ? BlocProvider<NotificationCenterBloc>(
          create: (context) => NotificationCenterBloc(builders: builders),
          child: Builder(
            builder: (BuildContext context) => Stack(
              alignment: alignment,
              children: [
                child == null ? Container() : child!,
                buildNotifications(context)
              ],
            ),
          ),
        )
      : BlocProvider<NotificationCenterBloc>.value(
          value: notificationCenterBloc!,
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

            return Container(
              child: SingleChildScrollView(
                child: Column(
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
      Column(
        key: UniqueKey(),
        mainAxisSize: MainAxisSize.min,
        children: [
          Dismissible(
            direction: DismissDirection.horizontal,
            key: UniqueKey(),
            onDismissed: (_) {
              BlocProvider.of<NotificationCenterBloc>(context).add(
                NotificationClosed(
                  notification: notification.notification,
                ),
              );
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    notification.builder.headerBuilder(
                      notification.notification,
                    ),
                    notification.builder.bodyBuilder(
                      notification.notification,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      );
}
