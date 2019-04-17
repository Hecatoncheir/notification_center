import 'package:flutter/material.dart';

class NotificationBodyModel {
  String text;
  TextStyle textStyle;
  TextStyle defaultTextStyle = TextStyle(fontSize: 16);

  EdgeInsets padding;

  BoxDecoration decoration;
  BoxDecoration defaultDecoration = BoxDecoration();

  Widget Function(Widget) animator;

  NotificationBodyModel(
      {this.text,
      this.textStyle,
      this.animator,
      this.padding = const EdgeInsets.all(0),
      this.decoration});
}
