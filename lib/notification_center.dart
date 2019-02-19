library notification_center;

import 'package:flutter/material.dart';

import 'package:notification_center/blocs.dart' show NotificationCenterBloc;

class NotificationCenter extends StatefulWidget {
  final NotificationCenterBloc notificationCenterBloc;

  NotificationCenter({@required this.notificationCenterBloc});

  @override
  _NotificationCenterState createState() => _NotificationCenterState();
}

class _NotificationCenterState extends State<NotificationCenter> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
