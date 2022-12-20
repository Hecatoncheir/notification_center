import 'package:flutter/widgets.dart';
import 'package:notification_center/notification_center.dart';

// ignore: avoid-returning-widgets
Widget notificationOneByOneAnimationBuilder({
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
  BorderRadiusGeometry? borderRadius,
  BoxConstraints? constraints,
}) {
  return _NotificationOneByOneAnimation(
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
    borderRadius: borderRadius,
    constraints: constraints,
  );
}

class _NotificationOneByOneAnimation extends StatelessWidget {
  final Widget? header;
  final String? headerText;
  final EdgeInsetsGeometry? headerPadding;
  final Color? headerBackground;
  final Color? headerForeground;

  final Widget? body;
  final String? bodyText;
  final EdgeInsetsGeometry? bodyPadding;
  final Color? bodyBackground;
  final Color? bodyForeground;

  final BoxDecoration? decoration;
  final BorderRadiusGeometry? borderRadius;
  final BoxConstraints? constraints;

  const _NotificationOneByOneAnimation({
    this.header,
    this.headerText,
    this.headerPadding,
    this.headerBackground,
    this.headerForeground,
    this.body,
    this.bodyText,
    this.bodyPadding,
    this.bodyBackground,
    this.bodyForeground,
    this.decoration,
    this.borderRadius,
    this.constraints,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: Container(
        decoration: decoration?.copyWith(
          borderRadius: borderRadius,
        ),
        constraints: constraints,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _OneByOneAnimation(
              delayed: Duration.zero,
              duration: const Duration(milliseconds: 200),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: BaseNotificationHeader(
                      header: header,
                      headerText: headerText,
                      headerPadding: headerPadding,
                      headerBackground: headerBackground,
                      headerForeground: headerForeground,
                    ),
                  ),
                ],
              ),
            ),
            _OneByOneAnimation(
              delayed: const Duration(milliseconds: 400),
              duration: const Duration(milliseconds: 200),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: BaseNotificationBody(
                      body: body,
                      bodyText: bodyText,
                      bodyPadding: bodyPadding,
                      bodyBackground: bodyBackground,
                      bodyForeground: bodyForeground,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OneByOneAnimation extends StatefulWidget {
  final Widget child;
  final Duration delayed;
  final Duration duration;

  const _OneByOneAnimation({
    required this.child,
    required this.delayed,
    required this.duration,
    Key? key,
  }) : super(key: key);

  @override
  _OneByOneAnimationState createState() => _OneByOneAnimationState();
}

class _OneByOneAnimationState extends State<_OneByOneAnimation>
    with TickerProviderStateMixin {
  late final AnimationController animationController;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      vsync: this,
      duration: widget.duration,
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
      widget.delayed,
      () => mounted ? animationController.forward() : null,
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
