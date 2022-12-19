// ignore_for_file: no_leading_underscores_for_local_identifiers, prefer_if_null_operators

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
    final _body = body;
    final _bodyText = bodyText;

    return Container(
      color: bodyBackground,
      padding: bodyPadding,
      child: _body != null
          ? _body
          : _bodyText == null
              ? Container()
              : Text(
                  _bodyText,
                  style: TextStyle(
                    color: bodyForeground,
                  ),
                ),
    );
  }
}
