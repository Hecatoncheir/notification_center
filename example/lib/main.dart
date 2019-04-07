import 'package:flutter/material.dart';

import 'package:notification_center/blocs/notification_center.dart'
    show NotificationCenterBloc;

import 'package:notification_center/notification_center.dart'
    show NotificationCenterWidget;

import 'package:notification_center/models.dart'
    show NotificationModel, NotificationHeader, NotificationBody;

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

      Future.delayed(Duration(seconds: 2), () {
        final notification = NotificationModel(
            decoration: NotificationDecoration,
            margin: EdgeInsets.all(5),
            padding: EdgeInsets.all(10),
            header: NotificationHeader(
                padding: EdgeInsets.all(3),
                text: 'Second notification header',
                decoration: NotificationHeaderDecoration),
            body: NotificationBody(
                padding: EdgeInsets.all(3),
                decoration: NotificationBodyDecoration,
                text: 'Second notification body'));
        notificationCenterBloc.notifications.add(notification);

        Future.delayed(Duration(seconds: 3), () {
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
          child: Scaffold(
            appBar: AppBar(
                title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Expanded(child: Text('Plugin example app')),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      /// Notifications controls
                      GestureDetector(
                        onTap: () =>
                            notificationCenterBloc.getAllNotifications(),
                        child: Chip(
                          labelStyle: TextStyle(color: Colors.black),
                          backgroundColor: Colors.white,
                          avatar: CircleAvatar(
                            backgroundColor: Colors.lightGreen,
                            child: StreamBuilder(
                              stream: notificationCenterBloc.notificationsCount,
                              builder: (_, snapshot) {
                                if (snapshot.data != null) {
                                  return Text(snapshot.data.toString(),
                                      style: TextStyle(color: Colors.white));
                                } else {
                                  return Text(
                                      notificationCenterBloc.history.length
                                          .toString(),
                                      style: TextStyle(color: Colors.white));
                                }
                              },
                            ),
                          ),
                          label: Text('Show'),
                        ),
                      ),
                      GestureDetector(
                        onTap: () =>
                            notificationCenterBloc.closeAllNotifications(),
                        child: Chip(
                          backgroundColor: Colors.white,
                          label: Text('Close'),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            )),
            body: Padding(
              padding: EdgeInsets.all(10),

              /// NotificationCenter
              child: NotificationCenterWidget(
                notificationCenterBloc: notificationCenterBloc,
                child: Center(
                  child: Text('Running on: flutter \n'),
                ),
              ),
            ),
          ),
        ),
      );
}

const NotificationDecoration = BoxDecoration();

const NotificationHeaderDecoration = BoxDecoration();

const NotificationBodyDecoration = BoxDecoration();
