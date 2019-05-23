import 'package:flutter/material.dart';

/// OneByOneBodyAnimation - function with body parameter.
Widget oneByOneBodyAnimation(Widget bodyWidget) =>
    _OneByOneBodyAnimation(bodyWidget);

/// _OneByOneBodyAnimation - widget for body animation.
class _OneByOneBodyAnimation extends StatefulWidget {
  final Widget bodyWidget;

  /// Constructor.
  const _OneByOneBodyAnimation(this.bodyWidget);

  @override
  _OneByOneBodyAnimationState createState() => _OneByOneBodyAnimationState();
}

class _OneByOneBodyAnimationState extends State<_OneByOneBodyAnimation>
    with TickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(
        Duration(milliseconds: 260), () => _animationController.forward());

    return FadeTransition(
      // ignore: prefer_int_literals
      opacity: Tween(begin: .0, end: 1.0).animate(CurvedAnimation(
          curve: Curves.bounceIn, parent: _animationController)),
      child: SizeTransition(
        // ignore: prefer_int_literals
        sizeFactor: Tween(begin: .0, end: 1.0).animate(CurvedAnimation(
            curve: Curves.bounceIn, parent: _animationController)),
        child: Container(child: widget.bodyWidget),
      ),
    );
  }
}
