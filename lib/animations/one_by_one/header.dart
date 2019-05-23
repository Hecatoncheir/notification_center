import 'package:flutter/material.dart';

/// OneByOneHeaderAnimation - function with header parameter.
Widget oneByOneHeaderAnimation(Widget headerWidget) =>
    _OneByOneHeaderAnimation(headerWidget);

/// _OneByOneHeaderAnimation - widget for header animation.
class _OneByOneHeaderAnimation extends StatefulWidget {
  final Widget headerWidget;

  const _OneByOneHeaderAnimation(this.headerWidget);

  @override
  _OneByOneHeaderAnimationState createState() =>
      _OneByOneHeaderAnimationState();
}

class _OneByOneHeaderAnimationState extends State<_OneByOneHeaderAnimation>
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
        Duration(milliseconds: 0), () => _animationController.forward());

    return FadeTransition(
      // ignore: prefer_int_literals
      opacity: Tween(begin: .0, end: 1.0).animate(CurvedAnimation(
          curve: Curves.bounceIn, parent: _animationController)),
      child: SizeTransition(
        // ignore: prefer_int_literals
        sizeFactor: Tween(begin: .0, end: 1.0).animate(CurvedAnimation(
            curve: Curves.bounceIn, parent: _animationController)),
        child: Container(child: widget.headerWidget),
      ),
    );
  }
}
