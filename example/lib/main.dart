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

      BoxDecoration secondNotificationDecoration() => BoxDecoration(
          color: Color(0xFFfecfbf),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: Color(0xFFb7315c)));

      Future.delayed(Duration(seconds: 2), () {
        final notification = NotificationModel(
            onlyOneNotificationShow: true,
            decoration: secondNotificationDecoration(),
            margin: EdgeInsets.all(3),
            padding: EdgeInsets.all(2),
            header: NotificationHeader(
                padding:
                    EdgeInsets.only(top: 10, left: 10, bottom: 2, right: 10),
                text: 'Second notification header',
                textStyle: TextStyle(
                    color: Color(0xFFb7315c),
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),
            body: NotificationBody(
                padding:
                    EdgeInsets.only(top: 5, left: 10, bottom: 10, right: 10),
                textStyle: TextStyle(color: Color(0xFFb7315c)),
                text: 'Second notification body'));
        notificationCenterBloc.notifications.add(notification);

        Future.delayed(Duration(seconds: 3), () {
          final notification = NotificationModel(
              header: NotificationHeader(text: 'Third notification header'),
              body: NotificationBody(text: 'Third notification body'));
          notificationCenterBloc.notifications.add(notification);

          Future.delayed(Duration(seconds: 4), () {
            final header = NotificationHeader(
                text: 'Fourth notification header',
                textStyle: TextStyle(color: Color(0xFFF0376E), fontSize: 18));

            final body = NotificationBody(
                text: 'Fourth notification body',
                padding: EdgeInsets.only(top: 5),
                textStyle: TextStyle(color: Color(0xFFF0376E), fontSize: 16));

            final notification = NotificationModel(
                header: header,
                body: body,
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.zero),
                    border: Border.all(color: Color(0xFFF0376E)),
                    color: Color(0xFFFFFAEB)));
            notificationCenterBloc.notifications.add(notification);
          });
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
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.fitHeight,
                                alignment: FractionalOffset.center,
                                image: AssetImage('images/background.png')),
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
          ),
        ),
      );
}

BoxDecoration notificationHeaderDecoration() => BoxDecoration();

BoxDecoration notificationBodyDecoration() => BoxDecoration();
