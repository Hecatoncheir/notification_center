import 'package:meta/meta.dart' show required;

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
  final Widget child;

  /// Constructor
  const NotificationCenterWidget(
      {@required this.notificationCenterBloc, this.child});

  @override
  Widget build(BuildContext context) => StreamBuilder(
      stream: notificationCenterBloc.notificationsForShow, builder: _builder);

  Widget _builder(
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

  Widget _buildNotification(NotificationModel notification) =>
      Dismissible(key: UniqueKey(), child: NotificationWidget(notification));
}
