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
class ExampleWidget extends StatelessWidget {
  const ExampleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final notification = Notification(
      headerText: "Header",
      bodyText: "Body",
    );
    NotificationCenter.of(context).showNotification(notification);

    Future.delayed(Duration(seconds: 5), () {
      NotificationCenter.of(context).showAllNotifications();
    });

    return const Placeholder();
  }
}
