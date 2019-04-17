import 'package:flutter/material.dart';

class NotificationHeaderModel {
  String text;
  TextStyle textStyle;
  TextStyle defaultTextStyle = TextStyle(fontSize: 18);

  BoxDecoration decoration;
  BoxDecoration defaultDecoration = BoxDecoration();

  EdgeInsets padding;

  Widget Function(Widget) animator;

  NotificationHeaderModel(
      {this.text,
      this.textStyle,
      this.animator,
      this.padding = const EdgeInsets.only(bottom: 5),
      this.decoration});
}
