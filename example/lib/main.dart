import 'package:flutter/material.dart' hide Notification;
import 'package:notification_center/notification_center.dart';

void main() => runApp(const Application());

// ignore: prefer-match-file-name
class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: NotificationCenter(
          child: ExampleWidget(),
        ),
      ),
    );
  }
}

// ignore: prefer-single-widget-per-file
class ExampleWidget extends StatefulWidget {
  const ExampleWidget({super.key});

  @override
  State<ExampleWidget> createState() => _ExampleWidgetState();
}

class _ExampleWidgetState extends State<ExampleWidget> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      int seconds = 3;

      final infoNotification = Info(
        headerText: "Info notification header",
        bodyText: "Info notification body",
        constraints: BoxConstraints(maxWidth: 260),
        notificationBuilder: notificationFadeAnimationBuilder,
      );
      await Future.delayed(
        Duration(seconds: seconds),
        () => NotificationCenter.of(context).showNotification(infoNotification),
      );

      final warningNotification = Warning(
        headerText: "Warning notification header",
        bodyText: "Warning notification body",
        constraints: BoxConstraints(maxWidth: 260),
        notificationBuilder: notificationOneByOneAnimationBuilder,
      );
      await Future.delayed(
        Duration(seconds: seconds),
        () => NotificationCenter.of(context)
            .showNotification(warningNotification),
      );

      final errorNotification = Error(
        headerText: "Error notification header",
        bodyText: "Error notification body",
        constraints: BoxConstraints(maxWidth: 260),
      );
      await Future.delayed(
        Duration(seconds: seconds),
        () =>
            NotificationCenter.of(context).showNotification(errorNotification),
      );

      const showAllDelay = 4;
      Future.delayed(
        Duration(seconds: showAllDelay),
        () => NotificationCenter.of(context).showAllNotifications(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: Placeholder(
                  child: Opacity(
                    // ignore: no-magic-number
                    opacity: 0.6,
                    child: Image.asset(
                      "images/background.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
