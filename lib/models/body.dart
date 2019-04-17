import 'package:flutter/material.dart';

/// NotificationBodyModel - model with data for notification body part.
class NotificationBodyModel {
  /// text - content of body.
  String text;

  /// textStyle - style of body content.
  TextStyle textStyle;

  /// defaultTextStyle - default style of body content.
  TextStyle defaultTextStyle = TextStyle(fontSize: 16);

  // ignore: public_member_api_docs
  EdgeInsets padding;

  // ignore: public_member_api_docs
  BoxDecoration decoration;

  // ignore: public_member_api_docs
  BoxDecoration defaultDecoration = BoxDecoration();

  /// animator - widget with animation controller and other for make animation.
  Widget Function(Widget) animator;

  /// Constructor.
  NotificationBodyModel(
      {this.text,
      this.textStyle,
      this.animator,
      this.padding = const EdgeInsets.all(0),
      this.decoration});
}
