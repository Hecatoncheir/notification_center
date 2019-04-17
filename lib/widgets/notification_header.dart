import 'package:flutter/material.dart';
import 'package:notification_center/models.dart' show NotificationHeaderModel;

/// NotificationHeaderWidget - widget with content of notification header.
class NotificationHeaderWidget extends StatelessWidget {
  /// header - model with data for notification header.
  final NotificationHeaderModel header;

  /// Constructor.
  const NotificationHeaderWidget(this.header);

  @override
  Widget build(BuildContext context) => header.animator == null
      ? _buildHeader()
      : header.animator(_buildHeader());

  Widget _buildHeader() => Row(key: key, children: <Widget>[
        Expanded(
            child: Container(
          decoration: header.decoration ??= header.defaultDecoration,
          padding: header.padding,
          child: header.textStyle == null
              ? Text(
                  header.text,
                  style: header.defaultTextStyle,
                )
              : Text(header.text, style: header.textStyle),
        ))
      ]);
}
