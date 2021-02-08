import 'package:flutter/material.dart';
import 'package:notification_center/models.dart' show NotificationBodyModel;

/// NotificationBodyWidget - widget with content of notification body.
class NotificationBodyWidget extends StatelessWidget {
  /// body - model with data for notification body.
  final NotificationBodyModel body;

  /// Constructor
  const NotificationBodyWidget(this.body);

  @override
  Widget build(BuildContext context) =>
      body.animator == null ? _buildBody() : body.animator!(_buildBody());

  Widget _buildBody() => Container(
        child: Row(
          key: key,
          children: <Widget>[
            Expanded(
              child: Container(
                decoration: body.decoration,
                padding: body.padding,
                child: Text(
                  body.text,
                  style: body.textStyle,
                ),
              ),
            )
          ],
        ),
      );
}
