import 'package:flutter/painting.dart';
import 'package:notification_center/notification_center.dart';

class Info extends Notification {
  const Info({
    super.key,
    super.header,
    super.headerText,
    super.headerPadding,
    super.headerBackground = const Color(0xFFAEC1D9),
    super.headerForeground = const Color(0xFF3C6282),
    super.body,
    super.bodyText,
    super.bodyPadding,
    super.bodyBackground = const Color(0xFFE7EEF7),
    super.bodyForeground = const Color(0xFF3C6282),
    super.duration,
    super.decoration = const BoxDecoration(
      border: Border.fromBorderSide(BorderSide(color: Color(0xFF3C6282))),
    ),
    super.borderRadius,
    super.constraints,
    super.notificationBuilder,
  });
}
