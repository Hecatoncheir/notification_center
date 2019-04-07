import 'dart:async';

import 'package:meta/meta.dart' show required;

import 'package:flutter/material.dart';

import 'package:notification_center/models.dart' show NotificationModel;

import 'package:notification_center/blocs.dart' show NotificationCenterBloc;

import 'package:notification_center/models.dart'
    show
        NotificationModel,
        NotificationHeader,
        NotificationBody,
        ControlPanelModel;

/// NotificationCenterWidget  - widget for show notifications.
class NotificationCenterWidget extends StatelessWidget {
  final NotificationCenterBloc notificationCenterBloc;

  final Widget child;

  final ControlPanelModel controlPanelModel;

  /// Constructor
  const NotificationCenterWidget(
      {@required this.notificationCenterBloc,
      this.controlPanelModel,
      this.child});

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

  Widget _buildNotifications(List<NotificationModel> notifications) {
    final _notifications = <Widget>[];
    for (NotificationModel notification in notifications) {
      _notifications.add(_buildNotification(notification));
    }

    final _widgets = <Widget>[]
      ..add(_buildNotificationCenterControlPanel())
      ..add(ListView(
        shrinkWrap: true,
        children: _notifications,
      ));

    return Column(children: _widgets);
  }

  Widget _buildNotificationCenterControlPanel() => StreamBuilder(
        stream: notificationCenterBloc.controlPanelReady,
        builder: (_, snapshot) {
          if (snapshot.data == false) {
            return Container();
          } else {
            return Container(
              decoration: controlPanelModel.decoration,
              child: Row(children: <Widget>[
                FlatButton(
                    onPressed: notificationCenterBloc.getAllNotifications,
                    child: Text(
                      controlPanelModel.showAllText +
                          ' (${notificationCenterBloc.history.length})',
                      style: TextStyle(color: controlPanelModel.textColor),
                    )),
                FlatButton(
                  onPressed: notificationCenterBloc.closeAllNotifications,
                  child: Text(
                    controlPanelModel.closeAllText,
                    style: TextStyle(color: controlPanelModel.textColor),
                  ),
                )
              ]),
            );
          }
        },
      );

  Widget _buildNotification(NotificationModel notification) => Dismissible(
        key: UniqueKey(),
        child: Column(
          children: <Widget>[
            _buildNotificationHeader(notification.header),
            _buildNotificationBody(notification.body)
          ],
        ),
      );

  Widget _buildNotificationHeader(NotificationHeader header) =>
      Row(children: <Widget>[Flexible(child: Text(header.text))]);

  Widget _buildNotificationBody(NotificationBody body) =>
      Row(children: <Widget>[Flexible(child: Text(body.text))]);
}
