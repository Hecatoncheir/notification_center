import 'package:flutter/widgets.dart';

class NotificationModel {
  NotificationHeader header;
  NotificationBody body;

  bool onlyOneNotificationShow;

  NotificationModel(
      {this.header, this.body, this.onlyOneNotificationShow = false});
}

class NotificationHeader {
  String text;
  BoxDecoration decoration;
  NotificationHeader({this.text, this.decoration});
}

class NotificationBody {
  String text;
  BoxDecoration decoration;
  NotificationBody({this.text, this.decoration});
}
