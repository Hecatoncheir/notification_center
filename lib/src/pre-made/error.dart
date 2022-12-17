import 'package:flutter/painting.dart';
import 'package:notification_center/notification_center.dart';

class Error extends Notification {
  const Error({
    super.key,
    super.header,
    super.headerText,
    super.headerPadding,
    super.headerBackground = const Color(0xFFD77E9F),
    super.headerForeground = const Color(0xFFFFFFFF),
    super.body,
    super.bodyText,
    super.bodyPadding,
    super.bodyBackground = const Color(0xFFF8CCC0),
    super.bodyForeground = const Color(0xFFB84C71),
    super.decoration = const BoxDecoration(
      border: Border.fromBorderSide(BorderSide(color: Color(0xFFB84C71))),
    ),
    super.constraints,
    super.notificationBuilder,
  });
}
