import 'package:flutter/material.dart';
import 'package:notification_center/models.dart'
    show NotificationHeaderModel, NotificationBodyModel;

import 'package:notification_center/animations.dart' show fadeInAnimation;

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
  BoxDecoration? decoration;

  /// showWithNotificationsFromHistory - for show
  /// notification with other from history.
  bool showWithNotificationsFromHistory;

  /// animator - widget with animation controller and other for make animation.
  Widget Function(Widget)? animator;

  /// Constructor.
  NotificationModel({
    required this.header,
    required this.body,
    this.margin = const EdgeInsets.all(8),
    this.padding = const EdgeInsets.all(6),
    this.animator = fadeInAnimation,
    this.decoration,
    this.showWithNotificationsFromHistory = false,
  }) {
    this.decoration = BoxDecoration(
      borderRadius: BorderRadius.circular(6),
      border: Border.all(
        color: Colors.white.withOpacity(0.6),
      ),
    );
  }
}
