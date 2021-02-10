import 'package:flutter/material.dart' hide Notification;
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:notification_center/models/interface.dart';
import 'package:notification_center/notification_center.dart';

void main() => runApp(Application());

class ErrorNotification extends NotificationBase {
  ErrorNotification({
    required String header,
    required String body,
    Duration? closeAfter,
    Future<dynamic>? waitBeforeClose,
  }) : super(
          header: header,
          body: body,
          closeAfter: closeAfter,
          waitBeforeClose: waitBeforeClose,
        );
}

class SuccessfulNotification extends Notification {
  String header;
  String body;

  SuccessfulNotification({
    required this.header,
    required this.body,
  });
}

class InformationNotification implements Notification {
  String body;
  InformationNotification({required this.body});
}

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
                headerBuilder: (_, notification) {
                  return OneByOneHeaderAnimation(
                    child: Container(
                      width: 300,
                      margin: EdgeInsets.only(top: 8),
                      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                      decoration: BoxDecoration(
                        color: Color(0xFFffe1af),
                        border: Border(
                          left: BorderSide(color: Color(0xFFF0376E)),
                          top: BorderSide(color: Color(0xFFF0376E)),
                          right: BorderSide(color: Color(0xFFF0376E)),
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              notification.header,
                              style: TextStyle(color: Color(0xFFb7315c)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                bodyBuilder: (_, notification) {
                  return OneByOneBodyAnimationDelegate(
                    child: Container(
                      width: 300,
                      margin: EdgeInsets.only(bottom: 8),
                      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 8),
                      decoration: BoxDecoration(
                        color: Color(0xFFfffae9),
                        border: Border(
                          left: BorderSide(color: Color(0xFFF0376E)),
                          bottom: BorderSide(color: Color(0xFFF0376E)),
                          right: BorderSide(color: Color(0xFFF0376E)),
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              notification.body,
                              style: TextStyle(color: Color(0xFFF0376E)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              NotificationBuilder<SuccessfulNotification>(
                headerBuilder: (_, notification) {
                  return OneByOneHeaderAnimation(
                    child: Container(
                      width: 300,
                      margin: EdgeInsets.only(top: 8),
                      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                      decoration: BoxDecoration(
                        color: Color(0xFFdde46c),
                        border: Border(
                          left: BorderSide(color: Color(0xFFdde46c)),
                          top: BorderSide(color: Color(0xFFdde46c)),
                          right: BorderSide(color: Color(0xFFdde46c)),
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              notification.header,
                              style: TextStyle(color: Color(0xFF6d7a8f)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                bodyBuilder: (_, notification) {
                  return OneByOneBodyAnimationDelegate(
                    child: Container(
                      width: 300,
                      margin: EdgeInsets.only(bottom: 8),
                      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 8),
                      decoration: BoxDecoration(
                        color: Color(0xFFfffae9),
                        border: Border(
                          left: BorderSide(color: Color(0xFFdde46c)),
                          bottom: BorderSide(color: Color(0xFFdde46c)),
                          right: BorderSide(color: Color(0xFFdde46c)),
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              notification.body,
                              style: TextStyle(color: Color(0xFF6d7a8f)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              NotificationBuilder<ErrorNotification>(
                headerBuilder: (bloc, notification) {
                  return ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(6),
                      topRight: Radius.circular(6),
                    ),
                    child: Container(
                      width: 300,
                      padding: EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: Color(0xFFfecfbf),
                        border: Border(
                          left: BorderSide(color: Color(0xFFF0376E)),
                          top: BorderSide(color: Color(0xFFF0376E)),
                          right: BorderSide(color: Color(0xFFF0376E)),
                        ),
                      ),
                      child: Text(
                        notification.header,
                        style: TextStyle(
                          color: Color(0xFFb7315c),
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                },
                bodyBuilder: (_, notification) {
                  return ClipRRect(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(6),
                      bottomRight: Radius.circular(6),
                    ),
                    child: Container(
                      width: 300,
                      margin: EdgeInsets.only(bottom: 8),
                      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                      decoration: BoxDecoration(
                        color: Color(0xFFfecfbf),
                        border: Border(
                          left: BorderSide(color: Color(0xFFF0376E)),
                          bottom: BorderSide(color: Color(0xFFF0376E)),
                          right: BorderSide(color: Color(0xFFF0376E)),
                        ),
                      ),
                      child: Text(
                        notification.body,
                        style: TextStyle(
                          color: Color(0xFFb7315c),
                        ),
                      ),
                    ),
                  );
                },
              ),
              NotificationBuilder<InformationNotification>(
                bodyBuilder: (bloc, notification) {
                  return Dismissible(
                    direction: DismissDirection.horizontal,
                    key: UniqueKey(),
                    onDismissed: (_) {
                      bloc.add(
                        NotificationClosed(
                          notification: notification,
                        ),
                      );
                    },
                    child: Container(
                      width: 300,
                      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 8),
                      decoration: BoxDecoration(
                        color: Color(0xFFfffae9),
                        border: Border.all(color: Color(0xFFF0376E)),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              notification.body,
                              style: TextStyle(color: Color(0xFFF0376E)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
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
      final notification = InformationNotification(
        body: 'Information notification body',
      );

      final event = NotificationAdded(
        notification: notification,
      );

      BlocProvider.of<NotificationCenterBloc>(context).add(event);
    });

    Future.delayed(Duration(seconds: 2), () {
      final notification = ErrorNotification(
        header: 'Error notification header',
        body: 'Error notification body',
        closeAfter: Duration(seconds: 1),
      );

      final event = NotificationAdded(
        notification: notification,
      );

      BlocProvider.of<NotificationCenterBloc>(context).add(event);
    });

    Future.delayed(Duration(seconds: 3), () {
      final notification = NotificationBase(
        header: 'Base notification header',
        body: 'Base notification body',
        waitBeforeClose: () async {
          await Future.delayed(Duration(seconds: 3));
        }(),
      );

      final event = NotificationAdded(
        notification: notification,
      );

      BlocProvider.of<NotificationCenterBloc>(context).add(event);
    });

    Future.delayed(Duration(seconds: 4), () {
      final notification = SuccessfulNotification(
        header: 'Successful notification header',
        body: 'Successful notification body',
      );

      final event = NotificationAdded(
        notification: notification,
      );

      BlocProvider.of<NotificationCenterBloc>(context).add(event);
    });
  }

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
  Widget build(BuildContext context) => SafeArea(
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
      );
}
