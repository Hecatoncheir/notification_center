import 'dart:ui';

import 'package:meta/meta.dart' show required;

import 'package:flutter/material.dart';

import 'package:notification_center/models.dart' show NotificationModel;

import 'package:notification_center/blocs.dart' show NotificationCenterBloc;

import 'package:notification_center/models.dart'
    show NotificationModel, NotificationHeader, NotificationBody;

/// NotificationCenterWidget  - widget for show notifications.
class NotificationCenterWidget extends StatelessWidget {
  final NotificationCenterBloc notificationCenterBloc;

  final Widget child;

  /// Constructor
  const NotificationCenterWidget(
      {@required this.notificationCenterBloc, this.child});

  @override
  Widget build(BuildContext context) => StreamBuilder(
      stream: notificationCenterBloc.notificationsForShow, builder: builder);

  Widget builder(
      BuildContext context, AsyncSnapshot<List<NotificationModel>> snapshot) {
    Widget _widget = child;

    if (snapshot.connectionState == ConnectionState.active) {
      _widget =
          Stack(children: <Widget>[child, _buildNotifications(snapshot.data)]);
    }

    return _widget;
  }

  Widget _buildNotifications(List<NotificationModel> notifications) =>
      ListView.builder(
          itemCount: notifications.length,
          shrinkWrap: true,
          itemBuilder: (_, index) => _buildNotification(notifications[index]));

  Widget _buildNotification(NotificationModel notification) => Dismissible(
        key: UniqueKey(),
        child: Container(
          margin: notification.margin,
          padding: notification.padding,
          child: ClipRect(
            child: notification.decoration != null
                ? Column(
                    children: <Widget>[
                      _buildNotificationHeader(notification.header),
                      _buildNotificationBody(notification.body)
                    ],
                  )
                : SizedBox(
                    width: double.infinity,
                    height: 53,
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                          decoration: notification.defaultDecoration,
                          padding: notification.padding,
                          margin: notification.margin,
                          child: Column(
                            children: <Widget>[
                              _buildNotificationHeader(notification.header),
                              _buildNotificationBody(notification.body)
                            ],
                          )),
                    )),
          ),
        ),
      );

  Widget _buildNotificationHeader(NotificationHeader header) =>
      Row(children: <Widget>[
        Flexible(
            child: Padding(
          padding: header.padding,
          child: header.decoration == null
              ? Text(
                  header.text,
                  overflow: TextOverflow.ellipsis,
                )
              : Text(header.text),
        ))
      ]);

  Widget _buildNotificationBody(NotificationBody body) =>
      Row(children: <Widget>[
        Flexible(
            child: Padding(
          padding: body.padding,
          child: body.decoration == null
              ? Text(
                  body.text,
                  overflow: TextOverflow.ellipsis,
                )
              : Text(body.text),
        ))
      ]);
}
