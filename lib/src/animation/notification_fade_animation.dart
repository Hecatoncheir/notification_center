import 'package:flutter/widgets.dart';
import 'package:notification_center/notification_center.dart';

// ignore: avoid-returning-widgets
Widget notificationFadeAnimationBuilder({
  Widget? header,
  String? headerText,
  EdgeInsetsGeometry? headerPadding,
  Color? headerBackground,
  Color? headerForeground,
  Widget? body,
  String? bodyText,
  EdgeInsetsGeometry? bodyPadding,
  Color? bodyBackground,
  Color? bodyForeground,
  BoxDecoration? decoration,
  BoxConstraints? constraints,
}) {
  return _NotificationFadeAnimation(
    child: BaseNotification(
      header: header,
      headerText: headerText,
      headerPadding: headerPadding,
      headerBackground: headerBackground,
      headerForeground: headerForeground,
      body: body,
      bodyText: bodyText,
      bodyPadding: bodyPadding,
      bodyBackground: bodyBackground,
      bodyForeground: bodyForeground,
      decoration: decoration,
      constraints: constraints,
    ),
  );
}

class _NotificationFadeAnimation extends StatefulWidget {
  final Widget child;

  const _NotificationFadeAnimation({
    required this.child,
  });

  @override
  State<_NotificationFadeAnimation> createState() =>
      _NotificationFadeAnimationState();
}

class _NotificationFadeAnimationState extends State<_NotificationFadeAnimation>
    with TickerProviderStateMixin {
  late final AnimationController animationController;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      const Duration(milliseconds: 0),
      () => animationController.forward(),
    );

    return FadeTransition(
      opacity: Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          curve: Curves.easeIn,
          parent: animationController,
        ),
      ),
      child: SizeTransition(
        sizeFactor: Tween(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            curve: Curves.easeIn,
            parent: animationController,
          ),
        ),
        child: widget.child,
      ),
    );
  }
}
