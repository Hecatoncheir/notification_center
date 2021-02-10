import 'package:flutter/material.dart';

/// OneByOneBodyAnimationDelegate  - widget for body animation.
class OneByOneBodyAnimationDelegate extends StatefulWidget {
  final Widget child;

  const OneByOneBodyAnimationDelegate({
    required this.child,
    Key? key,
  }) : super(key: key);

  @override
  _OneByOneBodyAnimationDelegateState createState() =>
      _OneByOneBodyAnimationDelegateState();
}

class _OneByOneBodyAnimationDelegateState
    extends State<OneByOneBodyAnimationDelegate> with TickerProviderStateMixin {
  AnimationController? _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );
  }

  @override
  void dispose() {
    _animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      Duration(milliseconds: 260),
      () {
        _animationController!.forward();
      },
    );

    return FadeTransition(
      // ignore: prefer_int_literals
      opacity: Tween(begin: .0, end: 1.0).animate(
        CurvedAnimation(
          curve: Curves.bounceIn,
          parent: _animationController!,
        ),
      ),
      child: SizeTransition(
        // ignore: prefer_int_literals
        sizeFactor: Tween(begin: .0, end: 1.0).animate(
          CurvedAnimation(
            curve: Curves.bounceIn,
            parent: _animationController!,
          ),
        ),
        child: Container(child: widget.child),
      ),
    );
  }
}
