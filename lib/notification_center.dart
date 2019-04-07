import 'package:meta/meta.dart' show required;

import 'package:flutter/material.dart';

import 'package:notification_center/models.dart' show NotificationModel;

import 'package:notification_center/blocs.dart' show NotificationCenterBloc;
import 'package:notification_center/models.dart';

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

  Widget _buildNotifications(List<NotificationModel> notifications) {
    final _widgets = <Widget>[]..add(_buildNotificationCenterControlPanel());

    for (NotificationModel notification in notifications) {
      _widgets.add(_buildNotification(notification));
    }

    return Column(children: _widgets);
  }

  Widget _buildNotificationCenterControlPanel() => Row(children: <Widget>[
        FlatButton(
            onPressed: null,
            child: Text('Show all notifications: '
                '${notificationCenterBloc.history.length}'))
      ]);

  Widget _buildNotification(NotificationModel notification) => Column(
        children: <Widget>[
          _buildNotificationHeader(notification.header),
          _buildNotificationBody(notification.body)
        ],
      );

  Widget _buildNotificationHeader(NotificationHeader header) =>
      Row(children: <Widget>[Flexible(child: Text(header.text))]);

  Widget _buildNotificationBody(NotificationBody body) =>
      Row(children: <Widget>[Flexible(child: Text(body.text))]);
}
