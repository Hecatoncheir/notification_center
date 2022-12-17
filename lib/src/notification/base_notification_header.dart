// ignore_for_file: no_leading_underscores_for_local_identifiers

part of 'notification.dart';

class BaseNotificationHeader extends StatelessWidget {
  final Widget? header;
  final String? headerText;
  final EdgeInsetsGeometry? headerPadding;
  final Color? headerBackground;
  final Color? headerForeground;

  const BaseNotificationHeader({
    super.key,
    this.header,
    this.headerText,
    this.headerPadding,
    this.headerBackground,
    this.headerForeground,
  });

  @override
  Widget build(BuildContext context) {
    return header == null
        ? headerText == null
            ? Container()
            : Container(
                color: headerBackground,
                padding: headerPadding,
                child: Text(
                  headerText ?? "",
                  style: TextStyle(
                    color: headerForeground,
                  ),
                ),
              )
        : Container();
  }
}