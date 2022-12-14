import 'package:flutter/material.dart';

part 'base_notification.dart';
part 'error.dart';
part 'info.dart';
part 'warning.dart';

typedef NotificationBuilder = Widget Function({
  Widget? header,
  String? headerText,
  Padding? headerPadding,
  Color? headerBackground,
  Color? headerForeground,
  Widget? body,
  String? bodyText,
  Padding? bodyPadding,
  Color? bodyBackground,
  Color? bodyForeground,
  Decoration? decoration,
});

class Notification extends StatefulWidget {
  final Widget? header;
  final String? headerText;
  final Padding? headerPadding;
  final Color? headerBackground;
  final Color? headerForeground;

  final Widget? body;
  final String? bodyText;
  final Padding? bodyPadding;
  final Color? bodyBackground;
  final Color? bodyForeground;

  final Decoration? decoration;

  final Alignment alignment;
  final bool isDismissible;
  final Duration displayDuration;

  final NotificationBuilder? notificationBuilder;

  const Notification({
    super.key,
    this.header,
    this.headerText,
    this.headerPadding,
    this.headerBackground,
    this.headerForeground,
    this.body,
    this.bodyText,
    this.bodyPadding,
    this.bodyBackground,
    this.bodyForeground,
    this.alignment = Alignment.bottomRight,
    this.isDismissible = true,
    this.displayDuration = const Duration(milliseconds: 4000),
    this.decoration,
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
          );
  }
}
