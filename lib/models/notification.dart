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
  TextStyle textStyle;

  BoxDecoration decoration;
  BoxDecoration defaultDecoration = BoxDecoration();

  EdgeInsets padding;

  NotificationHeader(
      {this.text,
      this.textStyle,
      this.padding = const EdgeInsets.all(0),
      this.decoration});
}

class NotificationBody {
  String text;
  TextStyle textStyle;

  EdgeInsets padding;

  BoxDecoration decoration;
  BoxDecoration defaultDecoration = BoxDecoration();

  NotificationBody(
      {this.text,
      this.textStyle,
      this.padding = const EdgeInsets.all(0),
      this.decoration});
}
