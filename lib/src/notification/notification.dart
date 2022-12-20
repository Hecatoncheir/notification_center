import 'package:flutter/widgets.dart';

part 'base_notification.dart';
part 'base_notification_body.dart';
part 'base_notification_header.dart';

typedef NotificationBuilder = Widget Function({
  Widget? header,
  String? headerText,
  EdgeInsetsGeometry? headerPadding,
  Color? headerBackground,
  Color? headerForeground,
  Widget? body,
  String? bodyText,
  EdgeInsetsGeometry? bodyPadding,
  Color? bodyBackground,
  Color? bodyForeground,
  BoxDecoration? decoration,
  BorderRadiusGeometry? borderRadius,
  BoxConstraints? constraints,
});

class Notification extends StatefulWidget {
  final Widget? header;
  final String? headerText;
  final EdgeInsetsGeometry? headerPadding;
  final Color? headerBackground;
  final Color? headerForeground;

  final Widget? body;
  final String? bodyText;
  final EdgeInsetsGeometry? bodyPadding;
  final Color? bodyBackground;
  final Color? bodyForeground;

  final BoxDecoration? decoration;
  final BorderRadiusGeometry? borderRadius;
  final BoxConstraints? constraints;

  final Duration duration;

  final NotificationBuilder? notificationBuilder;

  const Notification({
    super.key,
    this.header,
    this.headerText,
    this.headerPadding = const EdgeInsets.symmetric(
      horizontal: 6,
      vertical: 3,
    ),
    this.headerBackground = const Color(0xFFffffff),
    this.headerForeground = const Color(0xFF000000),
    this.body,
    this.bodyText,
    this.bodyPadding = const EdgeInsets.symmetric(
      horizontal: 6,
      vertical: 3,
    ),
    this.bodyBackground = const Color(0xFFffffff),
    this.bodyForeground = const Color(0xFF000000),
    this.duration = const Duration(milliseconds: 4000),
    this.decoration,
    this.borderRadius,
    this.constraints,
    this.notificationBuilder,
  });

  @override
  State<Notification> createState() => NotificationState();
}

class NotificationState extends State<Notification> {
  @override
  Widget build(BuildContext context) {
    final builder = widget.notificationBuilder;
    return builder != null
        ? builder(
            header: widget.header,
            headerText: widget.headerText,
            headerPadding: widget.headerPadding,
            headerBackground: widget.headerBackground,
            headerForeground: widget.headerForeground,
            body: widget.body,
            bodyText: widget.bodyText,
            bodyPadding: widget.bodyPadding,
            bodyBackground: widget.bodyBackground,
            bodyForeground: widget.bodyForeground,
            decoration: widget.decoration,
            constraints: widget.constraints,
          )
        : BaseNotification(
            header: widget.header,
            headerText: widget.headerText,
            headerPadding: widget.headerPadding,
            headerBackground: widget.headerBackground,
            headerForeground: widget.headerForeground,
            body: widget.body,
            bodyText: widget.bodyText,
            bodyPadding: widget.bodyPadding,
            bodyBackground: widget.bodyBackground,
            bodyForeground: widget.bodyForeground,
            decoration: widget.decoration,
            constraints: widget.constraints,
          );
  }
}
