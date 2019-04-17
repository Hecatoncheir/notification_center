import 'package:flutter/material.dart';

/// NotificationHeaderModel - model with data for notification header part.
class NotificationHeaderModel {
  // ignore: public_member_api_docs
  String text;

  // ignore: public_member_api_docs
  TextStyle textStyle;

  // ignore: public_member_api_docs
  TextStyle defaultTextStyle = TextStyle(fontSize: 18);

  // ignore: public_member_api_docs
  BoxDecoration decoration;

  // ignore: public_member_api_docs
  BoxDecoration defaultDecoration = BoxDecoration();

  // ignore: public_member_api_docs
  EdgeInsets padding;

  /// animator - widget with animation controller and other for make animation.
  Widget Function(Widget) animator;

  /// Constructor.
  NotificationHeaderModel(
      {this.text,
      this.textStyle,
      this.animator,
      this.padding = const EdgeInsets.only(bottom: 5),
      this.decoration});
}
