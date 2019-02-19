import 'package:flutter/material.dart';

import 'notification_simple_animation.dart' show NotificationSimpleAnimation;

class NotificationView extends StatefulWidget {
  Widget header;
  Widget body;

  NotificationView({this.header, this.body});

  @override
  _NotificationViewState createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
