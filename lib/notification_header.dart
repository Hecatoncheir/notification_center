import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:notification_center/models.dart' show NotificationHeader;

class NotificationHeaderWidget extends StatefulWidget {
  NotificationHeader header;

  NotificationHeaderWidget(this.header);

  @override
  _NotificationHeaderState createState() => _NotificationHeaderState();
}

class _NotificationHeaderState extends State<NotificationHeaderWidget>
    with TickerProviderStateMixin {
  GlobalKey key = GlobalKey();

  double height;
  double opacity = 0;

  AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));

    SchedulerBinding.instance.addPostFrameCallback((_) {
      // ignore: void_checks
      setState(() {
        final RenderBox renderBox = key.currentContext.findRenderObject();
        height = renderBox.size.height;
        opacity = 1;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(
        Duration(milliseconds: 0), () => _animationController.forward());

    return FadeTransition(
      // ignore: prefer_int_literals
      opacity: Tween(begin: .0, end: 1.0).animate(_animationController),
      child: SizeTransition(
        sizeFactor: _animationController,
        child: Container(
          height: height,
          child: Row(key: key, children: <Widget>[
            Expanded(
                child: Container(
              decoration: widget.header.decoration ??=
                  widget.header.defaultDecoration,
              padding: widget.header.padding,
              child: widget.header.textStyle == null
                  ? Text(
                      widget.header.text,
                      style: widget.header.defaultTextStyle,
                    )
                  : Text(widget.header.text, style: widget.header.textStyle),
            ))
          ]),
        ),
      ),
    );
  }
}
