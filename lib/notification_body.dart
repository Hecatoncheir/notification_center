import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:notification_center/models.dart' show NotificationBody;

class NotificationBodyWidget extends StatefulWidget {
  NotificationBody body;

  NotificationBodyWidget(this.body);

  @override
  _NotificationBodyState createState() => _NotificationBodyState();
}

class _NotificationBodyState extends State<NotificationBodyWidget>
    with TickerProviderStateMixin {
  GlobalKey key = GlobalKey();

  double height;
  double opacity = 0;

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      // ignore: void_checks
      setState(() {
        final RenderBox renderBox = key.currentContext.findRenderObject();
        final size = renderBox.size;

        height = size.height;
        opacity = 1;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) => AnimatedSize(
        duration: Duration(seconds: 1),
        vsync: this,
        curve: Curves.bounceInOut,
        child: Opacity(
          opacity: opacity,
          child: Container(
            height: height,
            child: Row(key: key, children: <Widget>[
              Expanded(
                  child: Container(
                decoration: widget.body.decoration ??=
                    widget.body.defaultDecoration,
                padding: widget.body.padding,
                child: widget.body.textStyle == null
                    ? Text(
                        widget.body.text,
                        style: widget.body.defaultTextStyle,
                      )
                    : Text(widget.body.text, style: widget.body.textStyle),
              ))
            ]),
          ),
        ),
      );
}
