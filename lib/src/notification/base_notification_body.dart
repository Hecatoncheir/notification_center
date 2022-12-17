// ignore_for_file: no_leading_underscores_for_local_identifiers

part of 'notification.dart';

class BaseNotificationBody extends StatelessWidget {
  final Widget? body;
  final String? bodyText;
  final EdgeInsetsGeometry? bodyPadding;
  final Color? bodyBackground;
  final Color? bodyForeground;

  const BaseNotificationBody({
    super.key,
    this.body,
    this.bodyText,
    this.bodyPadding,
    this.bodyBackground,
    this.bodyForeground,
  });

  @override
  Widget build(BuildContext context) {
    return body == null
        ? bodyText == null
            ? Container()
            : Container(
                color: bodyBackground,
                padding: bodyPadding,
                child: Text(
                  bodyText ?? "",
                  style: TextStyle(
                    color: bodyForeground,
                  ),
                ),
              )
        : Container();
  }
}
