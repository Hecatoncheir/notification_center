import 'dart:ui';
import 'package:flutter/material.dart';

import 'package:notification_center/models.dart'
    show NotificationModel, NotificationHeaderModel, NotificationBodyModel;

import 'package:notification_center/widgets/notification_body.dart';
import 'package:notification_center/widgets/notification_header.dart';

/// NotificationWidget - widget of one notification
class NotificationWidget extends StatelessWidget {
  /// NotificationModel - model of notification data
  final NotificationModel notification;

  /// Constructor
  const NotificationWidget(this.notification);

  @override
  Widget build(BuildContext context) => notification.animator == null
      ? _buildNotification(notification)
      : notification.animator!(_buildNotification(notification));

  Widget _buildNotification(NotificationModel notification) => Container(
        margin: notification.margin,
        child: notification.decoration != null
            ? Container(
                decoration: notification.decoration,
                padding: notification.padding,
                child: Column(
                  children: <Widget>[
                    _buildNotificationHeader(notification.header),
                    _buildNotificationBody(notification.body)
                  ],
                ))
            : ClipRect(
                child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                    decoration: notification.decoration,
                    padding: notification.padding,
                    child: Column(
                      children: <Widget>[
                        _buildNotificationHeader(notification.header),
                        _buildNotificationBody(notification.body)
                      ],
                    )),
              )),
      );

  Widget _buildNotificationHeader(NotificationHeaderModel header) =>
      NotificationHeaderWidget(header);

  Widget _buildNotificationBody(NotificationBodyModel body) =>
      NotificationBodyWidget(body);
}
