import 'package:flutter/material.dart';

import 'package:notification_center/blocs/notification_center.dart'
    show NotificationCenterBloc;

import 'package:notification_center/notification_center.dart'
    show NotificationCenterWidget;

import 'package:notification_center/models.dart'
    show
        NotificationModel,
        NotificationHeader,
        NotificationBody,
        ControlPanelModel;

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  NotificationCenterBloc notificationCenterBloc = NotificationCenterBloc();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  @override
  void dispose() {
    super.dispose();
    notificationCenterBloc.dispose();
  }

  Future<void> initPlatformState() async {
    Future.delayed(Duration(seconds: 1), () {
      final notification = NotificationModel(
          header: NotificationHeader(text: 'First notification header'),
          body: NotificationBody(text: 'First notification body'));
      notificationCenterBloc.notifications.add(notification);

      Future.delayed(Duration(seconds: 1), () {
        final notification = NotificationModel(
            header: NotificationHeader(text: 'Second notification header'),
            body: NotificationBody(text: 'Second notification body'));
        notificationCenterBloc.notifications.add(notification);

        Future.delayed(Duration(seconds: 1), () {
          final notification = NotificationModel(
              header: NotificationHeader(text: 'Third notification header'),
              body: NotificationBody(text: 'Third notification body'),
              onlyOneNotificationShow: true);
          notificationCenterBloc.notifications.add(notification);
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
        home: SafeArea(
          child: NotificationCenterWidget(
            controlPanelModel:
                ControlPanelModel(showAllText: 'Open', closeAllText: 'Close'),
            notificationCenterBloc: notificationCenterBloc,
            child: Scaffold(
              appBar: AppBar(
                title: const Text('Plugin example app'),
              ),
              body: Center(
                child: Text('Running on: flutter \n'),
              ),
            ),
          ),
        ),
      );
}
