import 'package:flutter/material.dart' hide Notification;
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:notification_center/notification_center.dart';

void main() => runApp(Application());

class Application extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: NotificationCenter(
          alignment: Alignment.topCenter,
          notificationCenterBloc: NotificationCenterBloc(
            builders: [
              NotificationBuilder<NotificationBase>(
                headerBuilder: (notification) => Text(notification.header),
                bodyBuilder: (notification) => Text(notification.body),
              ),
            ],
          ),
          child: MyApp(),
        ),
      ),
    );
  }
}

// ignore: public_member_api_docs
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 1), () {
      final notification = NotificationBase(
        header: 'First notification header',
        body: 'First notification body',
        waitBeforeClose: () async {
          await Future.delayed(Duration(seconds: 3));
        }(),
      );

      final event = NotificationAdded(
        notification: notification,
      );

      BlocProvider.of<NotificationCenterBloc>(context).add(event);
    });

    Future.delayed(Duration(seconds: 2), () {
      final notification = NotificationBase(
        header: 'Second notification header',
        body: 'Second notification body',
      );

      final event = NotificationAdded(
        notification: notification,
      );

      BlocProvider.of<NotificationCenterBloc>(context).add(event);
    });
  }

  // Future<void> init() async {
  //   Future.delayed(Duration(seconds: 1), () {
  //     BoxDecoration secondNotificationDecoration() => BoxDecoration(
  //         color: Color(0xFFfecfbf),
  //         borderRadius: BorderRadius.circular(6),
  //         border: Border.all(color: Color(0xFFb7315c)));
  //
  //     Future.delayed(Duration(seconds: 2), () {
  //       final notification = NotificationModel(
  //           showWithNotificationsFromHistory: true,
  //           decoration: secondNotificationDecoration(),
  //           margin: EdgeInsets.all(3),
  //           padding: EdgeInsets.all(2),
  //           header: NotificationHeaderModel(
  //               padding:
  //                   EdgeInsets.only(top: 10, left: 10, bottom: 2, right: 10),
  //               text: 'Second notification header',
  //               textStyle: TextStyle(
  //                   color: Color(0xFFb7315c),
  //                   fontSize: 16,
  //                   fontWeight: FontWeight.bold)),
  //           body: NotificationBodyModel(
  //               padding:
  //                   EdgeInsets.only(top: 5, left: 10, bottom: 10, right: 10),
  //               textStyle: TextStyle(color: Color(0xFFb7315c)),
  //               text: 'Second notification body'));
  //       notificationCenterBloc.notifications!.add(notification);
  //
  //       Future.delayed(Duration(seconds: 3), () {
  //         final notification = NotificationModel(
  //             header:
  //                 NotificationHeaderModel(text: 'Third notification header'),
  //             body: NotificationBodyModel(text: 'Third notification body'));
  //         notificationCenterBloc.notifications!.add(notification);
  //
  //         Future.delayed(Duration(seconds: 2), () {
  //           final header = NotificationHeaderModel(
  //               text: 'Fourth notification header',
  //               animator: oneByOneHeaderAnimation,
  //               padding: EdgeInsets.all(10),
  //               decoration: BoxDecoration(color: Color(0xFFFFE0B4)),
  //               textStyle: TextStyle(color: Color(0xFFA34F73), fontSize: 18));
  //
  //           final body = NotificationBodyModel(
  //               text: 'Fourth notification body',
  //               animation: oneByOneBodyAnimation,
  //               padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
  //               textStyle: TextStyle(color: Color(0xFFF0376E), fontSize: 16));
  //
  //           final notification = NotificationModel(
  //               header: header,
  //               body: body,
  //               padding: EdgeInsets.only(top: 0),
  //               margin: EdgeInsets.only(top: 10),
  //               decoration: BoxDecoration(
  //                   borderRadius: BorderRadius.all(Radius.zero),
  //                   border: Border.all(color: Color(0xFFF0376E)),
  //                   color: Color(0xFFFFFAEB)));
  //           notificationCenterBloc.notifications!.add(notification);
  //         });
  //       });
  //     });
  //   });
  // }

  Widget buildNotificationsCounterLayout(BuildContext context) {
    return BlocBuilder<NotificationCenterBloc, NotificationCenterState>(
      buildWhen: (previous, current) {
        if (current is NotificationsReadyForRender) return true;
        return false;
      },
      builder: (BuildContext context, state) {
        if (state is NotificationsReadyForRender) {
          return buildNotificationsCounter(
            context,
            state.allNotifications.length,
          );
        }

        return buildNotificationsCounter(context, 0);
      },
    );
  }

  Widget buildNotificationsCounter(BuildContext context, int counter) {
    return GestureDetector(
      onTap: () => BlocProvider.of<NotificationCenterBloc>(context)
          .add(NotificationsOpenAll()),
      child: Chip(
        labelStyle: TextStyle(color: Colors.black),
        backgroundColor: Colors.white,
        avatar: CircleAvatar(
          backgroundColor: Colors.lightGreen,
          child: Text(
            counter.toString(),
            style: TextStyle(color: Colors.white),
          ),
        ),
        label: Text('Show'),
      ),
    );
  }

  Widget buildCloseAllNotificationsButton(BuildContext context) {
    return GestureDetector(
      onTap: () => BlocProvider.of<NotificationCenterBloc>(context)
          .add(NotificationsCloseAll()),
      child: Chip(
        backgroundColor: Colors.white,
        label: Text('Close'),
      ),
    );
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
                      buildNotificationsCounterLayout(context),
                      buildCloseAllNotificationsButton(context),
                    ],
                  ),
                ),
              ],
            )),
            body: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      child: Text("Main body"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
