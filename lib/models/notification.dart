import 'package:flutter/material.dart';

/// Notification - model with data for notification.
class Notification {
  String header;
  String body;

  Alignment alignment;
  Duration? closeAfter;

  Notification({
    required this.header,
    required this.body,
    this.alignment = Alignment.topRight,
    this.closeAfter,
  });
}
