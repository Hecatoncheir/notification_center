import 'package:flutter/material.dart' hide Notification;
import 'package:notification_center/notification_center.dart';

void main() => runApp(const Application());

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
      int seconds = 1;

      final infoNotification = Info(
        headerText: "Info notification header",
        bodyText: "Info notification body",
        constraints: BoxConstraints(maxWidth: 260),
      );
      await Future.delayed(
        Duration(seconds: seconds),
        () => NotificationCenter.of(context).showNotification(infoNotification),
      ).then((_) => seconds++);

      final warningNotification = Warning(
        headerText: "Warning notification header",
        bodyText: "Warning notification body",
        constraints: BoxConstraints(maxWidth: 260),
      );
      await Future.delayed(
        Duration(seconds: seconds),
        () => NotificationCenter.of(context)
            .showNotification(warningNotification),
      ).then((_) => seconds++);

      final errorNotification = Error(
        headerText: "Error notification header",
        bodyText: "Error notification body",
        constraints: BoxConstraints(maxWidth: 260),
      );
      await Future.delayed(
        Duration(seconds: seconds),
        () =>
            NotificationCenter.of(context).showNotification(errorNotification),
      ).then((_) => seconds++);

      Future.delayed(
        Duration(seconds: seconds),
        () => NotificationCenter.of(context).showAllNotifications(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
