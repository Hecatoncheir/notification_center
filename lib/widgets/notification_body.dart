import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:notification_center/models.dart' show NotificationBodyModel;

class NotificationBodyWidget extends StatefulWidget {
  NotificationBodyModel body;

  NotificationBodyWidget(this.body);

  @override
  _NotificationBodyState createState() => _NotificationBodyState();
}

class _NotificationBodyState extends State<NotificationBodyWidget>
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
        Duration(milliseconds: 300), () => _animationController.forward());

    return FadeTransition(
      // ignore: prefer_int_literals
      opacity: Tween(begin: .0, end: 1.0).animate(CurvedAnimation(
          curve: Curves.bounceIn, parent: _animationController)),
      child: SizeTransition(
        sizeFactor: Tween(begin: .0, end: 1.0).animate(CurvedAnimation(
            curve: Curves.bounceIn, parent: _animationController)),
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
}
