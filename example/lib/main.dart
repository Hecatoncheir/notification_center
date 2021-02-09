import 'package:flutter/material.dart';

import 'package:notification_center/blocs/notification_center.dart'
    show NotificationCenterBloc;

import 'package:notification_center/notification_center.dart'
    show NotificationCenter;

import 'package:notification_center/models.dart'
    show NotificationModel, NotificationHeaderModel, NotificationBodyModel;

import 'package:notification_center/animations.dart'
    show oneByOneHeaderAnimation, oneByOneBodyAnimation;

void main() => runApp(MyApp());

// ignore: public_member_api_docs
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  NotificationCenterBloc notificationCenterBloc = NotificationCenterBloc();

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  void dispose() {
    super.dispose();
    notificationCenterBloc.dispose();
  }

  Future<void> init() async {
    Future.delayed(Duration(seconds: 1), () {
      final notification = NotificationModel(
          header: NotificationHeaderModel(text: 'First notification header'),
          body: NotificationBodyModel(text: 'First notification body'));
      notificationCenterBloc.notifications!.add(notification);

      BoxDecoration secondNotificationDecoration() => BoxDecoration(
          color: Color(0xFFfecfbf),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: Color(0xFFb7315c)));

      Future.delayed(Duration(seconds: 2), () {
        final notification = NotificationModel(
            showWithNotificationsFromHistory: true,
            decoration: secondNotificationDecoration(),
            margin: EdgeInsets.all(3),
            padding: EdgeInsets.all(2),
            header: NotificationHeaderModel(
                padding:
                    EdgeInsets.only(top: 10, left: 10, bottom: 2, right: 10),
                text: 'Second notification header',
                textStyle: TextStyle(
                    color: Color(0xFFb7315c),
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),
            body: NotificationBodyModel(
                padding:
                    EdgeInsets.only(top: 5, left: 10, bottom: 10, right: 10),
                textStyle: TextStyle(color: Color(0xFFb7315c)),
                text: 'Second notification body'));
        notificationCenterBloc.notifications!.add(notification);

        Future.delayed(Duration(seconds: 3), () {
          final notification = NotificationModel(
              header:
                  NotificationHeaderModel(text: 'Third notification header'),
              body: NotificationBodyModel(text: 'Third notification body'));
          notificationCenterBloc.notifications!.add(notification);

          Future.delayed(Duration(seconds: 2), () {
            final header = NotificationHeaderModel(
                text: 'Fourth notification header',
                animator: oneByOneHeaderAnimation,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(color: Color(0xFFFFE0B4)),
                textStyle: TextStyle(color: Color(0xFFA34F73), fontSize: 18));

            final body = NotificationBodyModel(
                text: 'Fourth notification body',
                animation: oneByOneBodyAnimation,
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                textStyle: TextStyle(color: Color(0xFFF0376E), fontSize: 16));

            final notification = NotificationModel(
                header: header,
                body: body,
                padding: EdgeInsets.only(top: 0),
                margin: EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.zero),
                    border: Border.all(color: Color(0xFFF0376E)),
                    color: Color(0xFFFFFAEB)));
            notificationCenterBloc.notifications!.add(notification);
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
                            notificationCenterBloc.showAllNotifications(),
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
              child: NotificationCenter(
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
