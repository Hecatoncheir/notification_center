import 'package:flutter/material.dart';

class NotificationBodyModel {
  String text;
  TextStyle textStyle;
  TextStyle defaultTextStyle = TextStyle(fontSize: 16);

  EdgeInsets padding;

  BoxDecoration decoration;
  BoxDecoration defaultDecoration = BoxDecoration();

  NotificationBodyModel(
      {this.text,
      this.textStyle,
      this.padding = const EdgeInsets.all(0),
      this.decoration});
}
