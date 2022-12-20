import 'package:flutter/painting.dart';
import 'package:notification_center/notification_center.dart';

class Warning extends Notification {
  const Warning({
    super.key,
    super.header,
    super.headerText,
    super.headerPadding,
    super.headerBackground = const Color(0xFFEFD8A7),
    super.headerForeground = const Color(0xffd77e9f),
    super.body,
    super.bodyText,
    super.bodyPadding,
    super.bodyBackground = const Color(0xFFF1EFDC),
    super.bodyForeground = const Color(0xffd77e9f),
    super.duration,
    super.decoration = const BoxDecoration(
      border: Border.fromBorderSide(BorderSide(color: Color(0xffd77e9f))),
    ),
    super.borderRadius,
    super.constraints,
    super.notificationBuilder,
  });
}
