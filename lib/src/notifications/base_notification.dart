part of 'notification.dart';

class BaseNotification extends StatelessWidget {
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
  });

  @override
  Widget build(BuildContext context) {
    final _header = header;
    final _headerText = headerText ?? "";
    final _headerPadding =
        headerPadding ?? const EdgeInsets.symmetric(horizontal: 6, vertical: 3);
    final _headerBackground = headerBackground ?? Colors.white;
    final _headerForeground = headerForeground ?? Colors.black;
    final _body = body;
    final _bodyText = bodyText ?? "";
    final _bodyPadding =
        bodyPadding ?? const EdgeInsets.symmetric(horizontal: 6, vertical: 3);
    final _bodyBackground = bodyBackground ?? Colors.white;
    final _bodyForeground = bodyForeground ?? Colors.black;

    return Container(
      decoration: decoration,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              header ??
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(_headerText),
                  ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              body ??
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(_bodyText),
                  ),
            ],
          ),
        ],
      ),
    );
  }
}
