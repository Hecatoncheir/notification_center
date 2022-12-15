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

  final Decoration? decoration;
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
    return Container(
      decoration: decoration,
      constraints: constraints,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: header ??
                    Container(
                      color: headerBackground,
                      padding: headerPadding,
                      child: Text(
                        headerText ?? "",
                        style: TextStyle(
                          color: headerForeground,
                        ),
                      ),
                    ),
              ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: body ??
                    Container(
                      color: bodyBackground,
                      padding: bodyPadding,
                      child: Text(
                        bodyText ?? "",
                        style: TextStyle(
                          color: bodyForeground,
                        ),
                      ),
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
