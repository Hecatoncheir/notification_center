// ignore_for_file: no_leading_underscores_for_local_identifiers

part of 'notification.dart';

class BaseNotification extends StatelessWidget {
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
  final BoxConstraints? constraints;

  const BaseNotification({
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
    this.decoration,
    this.constraints,
  });

  @override
  Widget build(BuildContext context) {
    final borderRadius = decoration?.borderRadius;
    return Container(
      decoration: decoration,
      constraints: constraints,
      child: ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.zero,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: BaseNotificationHeader(
                    header: header,
                    headerText: headerText,
                    headerPadding: headerPadding,
                    headerBackground: headerBackground,
                    headerForeground: headerForeground,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: BaseNotificationBody(
                    body: body,
                    bodyText: bodyText,
                    bodyPadding: bodyPadding,
                    bodyBackground: bodyBackground,
                    bodyForeground: bodyForeground,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
