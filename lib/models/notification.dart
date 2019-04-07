import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NotificationModel {
  NotificationHeader header;
  NotificationBody body;

  EdgeInsets margin;

  EdgeInsets padding;

  BoxDecoration decoration;
  BoxDecoration defaultDecoration =
      BoxDecoration(borderRadius: BorderRadius.circular(6));

  bool onlyOneNotificationShow;

  NotificationModel(
      {this.header,
      this.body,
      this.margin = const EdgeInsets.all(3),
      this.padding = const EdgeInsets.all(6),
      this.decoration,
      this.onlyOneNotificationShow = false});
}

class NotificationHeader {
  String text;
  BoxDecoration decoration;
  BoxDecoration defaultDecoration = BoxDecoration();

  NotificationHeader({this.text, this.decoration});
}

class NotificationBody {
  String text;
  BoxDecoration decoration;
  BoxDecoration defaultDecoration = BoxDecoration();

  NotificationBody({this.text, this.decoration});
}
