import 'package:flutter/material.dart';

/// fadeInAnimation - function with notification widget parameter.
Widget fadeInAnimation(Widget notificationWidget) =>
    _FadeInNotificationAnimation(notificationWidget);

/// _FadeInNotificationAnimation - widget for notification animation.
class _FadeInNotificationAnimation extends StatefulWidget {
  final Widget notificationWidget;

  /// Constructor.
  const _FadeInNotificationAnimation(this.notificationWidget);

  @override
  _FadeInNotificationAnimationState createState() =>
      _FadeInNotificationAnimationState();
}

class _FadeInNotificationAnimationState
    extends State<_FadeInNotificationAnimation> with TickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(
        Duration(milliseconds: 0), () => _animationController.forward());

    return FadeTransition(
      // ignore: prefer_int_literals
      opacity: Tween(begin: .0, end: 1.0).animate(CurvedAnimation(
          curve: Curves.bounceIn, parent: _animationController)),
      child: SizeTransition(
        // ignore: prefer_int_literals
        sizeFactor: Tween(begin: .0, end: 1.0).animate(CurvedAnimation(
            curve: Curves.bounceIn, parent: _animationController)),
        child: Container(child: widget.notificationWidget),
      ),
    );
  }
}
