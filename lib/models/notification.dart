import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:notification_center/models.dart'
    show NotificationHeaderModel, NotificationBodyModel;

class NotificationModel {
  NotificationHeaderModel header;
  NotificationBodyModel body;

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
