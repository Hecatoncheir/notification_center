import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:notification_center/models.dart'
    show NotificationHeaderModel, NotificationBodyModel;

/// NotificationModel - model with data for notification.
class NotificationModel {
  /// header - model with data for notification header part.
  NotificationHeaderModel header;

  /// body - model with data for notification body part.
  NotificationBodyModel body;

  // ignore: public_member_api_docs
  EdgeInsets margin;

  // ignore: public_member_api_docs
  EdgeInsets padding;

  // ignore: public_member_api_docs
  BoxDecoration decoration;

  // ignore: public_member_api_docs
  BoxDecoration defaultDecoration = BoxDecoration(
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: Colors.white.withOpacity(0.6)));

  // ignore: public_member_api_docs
  bool showWithNotificationsFromHistory;

  /// Constructor.
  NotificationModel(
      {this.header,
      this.body,
      this.margin = const EdgeInsets.all(8),
      this.padding = const EdgeInsets.all(6),
      this.decoration,
      this.showWithNotificationsFromHistory = false});
}
