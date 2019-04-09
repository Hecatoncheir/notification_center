import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NotificationModel {
  NotificationHeader header;
  NotificationBody body;

  EdgeInsets margin;

  EdgeInsets padding;

  BoxDecoration decoration;
  BoxDecoration defaultDecoration = BoxDecoration(
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: Colors.white.withOpacity(0.6)));

  bool onlyOneNotificationShow;

  NotificationModel(
      {this.header,
      this.body,
      this.margin = const EdgeInsets.all(8),
      this.padding = const EdgeInsets.all(6),
      this.decoration,
      this.onlyOneNotificationShow = false});
}

class NotificationHeader {
  String text;
  TextStyle textStyle;
  TextStyle defaultTextStyle = TextStyle(fontSize: 18);

  BoxDecoration decoration;
  BoxDecoration defaultDecoration = BoxDecoration();

  EdgeInsets padding;

  NotificationHeader(
      {this.text,
      this.textStyle,
      this.padding = const EdgeInsets.only(bottom: 5),
      this.decoration});
}

class NotificationBody {
  String text;
  TextStyle textStyle;
  TextStyle defaultTextStyle = TextStyle(fontSize: 16);

  EdgeInsets padding;

  BoxDecoration decoration;
  BoxDecoration defaultDecoration = BoxDecoration();

  NotificationBody(
      {this.text,
      this.textStyle,
      this.padding = const EdgeInsets.all(0),
      this.decoration});
}
