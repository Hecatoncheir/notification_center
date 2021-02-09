import 'package:flutter/material.dart' hide Notification;

import 'package:flutter_test/flutter_test.dart';

import 'package:notification_center/models/interface.dart';
import 'package:notification_center/models/notification.dart';
import 'package:notification_center/models/notification_builder.dart';

import 'package:notification_center/src/bloc/notification_center_bloc.dart';
import 'package:notification_center/src/notification_center.dart';

class SuccessfulNotification implements Notification {
  @override
  Duration? closeAfter;

  String header;
  String body;

  SuccessfulNotification({
    required this.header,
    required this.body,
    this.closeAfter,
  });
}

class ErrorNotification extends NotificationBase {
  ErrorNotification({
    required String header,
    required String body,
    Duration? closeAfter,
  }) : super(
          header: header,
          body: body,
          closeAfter: closeAfter,
        );
}

void main() {
  group('Notification center', () {
    NotificationCenterBloc? notificationCenterBloc;

    NotificationBuilder? notificationBuilder;

    setUp(() {
      notificationBuilder = NotificationBuilder<NotificationBase>(
        headerBuilder: (notification) => Text(notification.header),
        bodyBuilder: (notification) => Text(notification.body),
      );

      notificationCenterBloc = NotificationCenterBloc(builders: [
        notificationBuilder!,
      ]);
    });

    tearDown(() {
      notificationCenterBloc?.close();
    });

    testWidgets('can display main content with notification', (tester) async {
      Widget notificationCenter;

      const testText = 'Test text widget';

      notificationCenter = NotificationCenter(
        notificationCenterBloc: notificationCenterBloc!,
        builders: [
          notificationBuilder!,
        ],
        child: Text(testText),
      );

      await tester.pumpWidget(MaterialApp(home: notificationCenter));
      await tester.pumpAndSettle();

      expect(find.text(testText), findsOneWidget);
    });

    testWidgets('can show notification', (tester) async {
      Widget notificationCenter;

      notificationCenter = NotificationCenter(
        notificationCenterBloc: notificationCenterBloc!,
        builders: [
          notificationBuilder!,
        ],
        child: Offstage(),
      );

      await tester.pumpWidget(MaterialApp(home: notificationCenter));

      final notification = NotificationBase(
        header: 'Header',
        body: 'Body',
      );

      final event = NotificationAdded(notification: notification);
      notificationCenterBloc!.add(event);

      await tester.runAsync(() => tester.pump()).then((_) => tester.pump());
      await tester.pumpAndSettle();

      expect(find.text('Header'), findsOneWidget);
      expect(find.text('Body'), findsOneWidget);
    });

    // testWidgets(
    //   'can show notification with other notifications',
    //   (tester) async {
    //     // final successfulNotificationBuilder =
    //     //     NotificationBuilder<SuccessfulNotification>(
    //     //   headerBuilder: (notification) => Container(
    //     //     margin: EdgeInsets.all(3),
    //     //     padding: EdgeInsets.all(2),
    //     //     decoration: BoxDecoration(
    //     //       color: Color(0xFFfecfbf),
    //     //       borderRadius: BorderRadius.circular(6),
    //     //       border: Border.all(
    //     //         color: Color(0xFFb7315c),
    //     //       ),
    //     //     ),
    //     //     child: Container(
    //     //       padding: EdgeInsets.only(top: 10, left: 10, bottom: 2, right: 10),
    //     //       child: Text(
    //     //         notification.header,
    //     //         style: TextStyle(
    //     //           color: Color(0xFFb7315c),
    //     //           fontSize: 16,
    //     //           fontWeight: FontWeight.bold,
    //     //         ),
    //     //       ),
    //     //     ),
    //     //   ),
    //     //   bodyBuilder: (notification) => Container(
    //     //     padding: EdgeInsets.only(top: 5, left: 10, bottom: 10, right: 10),
    //     //     child: Text(
    //     //       notification.body,
    //     //       style: TextStyle(
    //     //         color: Color(0xFFb7315c),
    //     //       ),
    //     //     ),
    //     //   ),
    //     // );
    //
    //     final successfulNotificationBuilder =
    //         NotificationBuilder<SuccessfulNotification>(
    //       headerBuilder: (notification) => Text(notification.header),
    //       bodyBuilder: (notification) => Text(notification.body),
    //     );
    //
    //     Widget notificationCenter;
    //     notificationCenter = NotificationCenter(
    //       notificationCenterBloc: notificationCenterBloc!,
    //       builders: [
    //         successfulNotificationBuilder,
    //       ],
    //       child: Offstage(),
    //     );
    //
    //     await tester.pumpWidget(MaterialApp(home: notificationCenter));
    //
    //     final firstNotification = SuccessfulNotification(
    //       header: "First notification header",
    //       body: "First notification body",
    //     );
    //
    //     final firstNotificationEvent = NotificationAdded(
    //       notification: firstNotification,
    //     );
    //
    //     notificationCenterBloc!.add(firstNotificationEvent);
    //
    //     await tester.runAsync(() => tester.pump()).then((_) => tester.pump());
    //
    //     expect(find.text('First notification header'), findsOneWidget);
    //     expect(find.text('First notification body'), findsOneWidget);
    //
    //     // final secondNotification = SuccessfulNotification(
    //     //   header: "Second notification header",
    //     //   body: "Second notification body",
    //     // );
    //     //
    //     // final secondNotificationEvent = NotificationAdded(
    //     //   notification: secondNotification,
    //     // );
    //     //
    //     // notificationCenterBloc!.add(secondNotificationEvent);
    //     //
    //     // await tester.runAsync(() => tester.pump()).then((_) => tester.pump());
    //     // await tester.pumpAndSettle();
    //     //
    //     // expect(find.text('First notification header'), findsOneWidget);
    //     // expect(find.text('First notification body'), findsOneWidget);
    //     //
    //     // expect(find.text('Second notification header'), findsOneWidget);
    //     // expect(find.text('Second notification body'), findsOneWidget);
    //   },
    //   skip: true,
    // );
//
//     testWidgets('can hide all notifications', (tester) async {
//       Widget notificationCenter;
//
//       notificationCenter = NotificationCenter(
//         notificationCenterBloc: notificationCenterBloc!,
//         child: Offstage(),
//       );
//
//       await tester.pumpWidget(MaterialApp(home: notificationCenter));
//
//       final firstNotification = NotificationModel(
//           showWithNotificationsFromHistory: true,
//           decoration: BoxDecoration(
//               color: Color(0xFFfecfbf),
//               borderRadius: BorderRadius.circular(6),
//               border: Border.all(color: Color(0xFFb7315c))),
//           margin: EdgeInsets.all(3),
//           padding: EdgeInsets.all(2),
//           header: NotificationHeaderModel(
//               padding: EdgeInsets.only(top: 10, left: 10, bottom: 2, right: 10),
//               text: 'First notification header',
//               textStyle: TextStyle(
//                   color: Color(0xFFb7315c),
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold)),
//           body: NotificationBodyModel(
//               padding: EdgeInsets.only(top: 5, left: 10, bottom: 10, right: 10),
//               textStyle: TextStyle(color: Color(0xFFb7315c)),
//               text: 'First notification body'));
//
//       notificationCenterBloc!.notifications!.add(firstNotification);
//
//       await tester.runAsync(() => tester.pump()).then((_) => tester.pump());
//       await tester.pumpAndSettle();
//
//       expect(find.text('First notification header'), findsOneWidget);
//       expect(find.text('First notification body'), findsOneWidget);
//
//       final headerOfSecondNotification = NotificationHeaderModel(
//           text: 'Second notification header',
//           animator: oneByOneHeaderAnimation,
//           padding: EdgeInsets.all(10),
//           decoration: BoxDecoration(color: Color(0xFFFFE0B4)),
//           textStyle: TextStyle(color: Color(0xFFA34F73), fontSize: 18));
//
//       final bodyOfSecondNotification = NotificationBodyModel(
//           text: 'Second notification body',
//           animation: oneByOneBodyAnimation,
//           padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
//           textStyle: TextStyle(color: Color(0xFFF0376E), fontSize: 16));
//
//       final secondNotification = NotificationModel(
//           showWithNotificationsFromHistory: true, // that property
//           header: headerOfSecondNotification,
//           body: bodyOfSecondNotification,
//           padding: EdgeInsets.only(top: 0),
//           margin: EdgeInsets.only(top: 10),
//           decoration: BoxDecoration(
//               borderRadius: BorderRadius.all(Radius.zero),
//               border: Border.all(color: Color(0xFFF0376E)),
//               color: Color(0xFFFFFAEB)));
//
//       notificationCenterBloc!.notifications!.add(secondNotification);
//
//       await tester.runAsync(() => tester.pump()).then((_) => tester.pump());
//       await tester.pumpAndSettle();
//
//       expect(find.text('First notification header'), findsOneWidget);
//       expect(find.text('First notification body'), findsOneWidget);
//
//       expect(find.text('Second notification header'), findsOneWidget);
//       expect(find.text('Second notification body'), findsOneWidget);
//
//       notificationCenterBloc!.closeAllNotifications();
//
//       await tester.runAsync(() => tester.pump()).then((_) => tester.pump());
//       await tester.pumpAndSettle();
//
//       expect(find.text('First notification header'), findsNothing);
//       expect(find.text('First notification body'), findsNothing);
//
//       expect(find.text('Second notification header'), findsNothing);
//       expect(find.text('Second notification body'), findsNothing);
//     });
//
//     testWidgets('can show all notifications', (tester) async {
//       Widget notificationCenter;
//
//       notificationCenter = NotificationCenter(
//         notificationCenterBloc: notificationCenterBloc!,
//         child: Offstage(),
//       );
//
//       await tester.pumpWidget(MaterialApp(home: notificationCenter));
//
//       final firstNotification = NotificationModel(
//           showWithNotificationsFromHistory: true,
//           decoration: BoxDecoration(
//               color: Color(0xFFfecfbf),
//               borderRadius: BorderRadius.circular(6),
//               border: Border.all(color: Color(0xFFb7315c))),
//           margin: EdgeInsets.all(3),
//           padding: EdgeInsets.all(2),
//           header: NotificationHeaderModel(
//               padding: EdgeInsets.only(top: 10, left: 10, bottom: 2, right: 10),
//               text: 'First notification header',
//               textStyle: TextStyle(
//                   color: Color(0xFFb7315c),
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold)),
//           body: NotificationBodyModel(
//               padding: EdgeInsets.only(top: 5, left: 10, bottom: 10, right: 10),
//               textStyle: TextStyle(color: Color(0xFFb7315c)),
//               text: 'First notification body'));
//
//       notificationCenterBloc!.notifications!.add(firstNotification);
//
//       await tester.runAsync(() => tester.pump()).then((_) => tester.pump());
//       await tester.pumpAndSettle();
//
//       expect(find.text('First notification header'), findsOneWidget);
//       expect(find.text('First notification body'), findsOneWidget);
//
//       final headerOfSecondNotification = NotificationHeaderModel(
//           text: 'Second notification header',
//           animator: oneByOneHeaderAnimation,
//           padding: EdgeInsets.all(10),
//           decoration: BoxDecoration(color: Color(0xFFFFE0B4)),
//           textStyle: TextStyle(color: Color(0xFFA34F73), fontSize: 18));
//
//       final bodyOfSecondNotification = NotificationBodyModel(
//           text: 'Second notification body',
//           animation: oneByOneBodyAnimation,
//           padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
//           textStyle: TextStyle(color: Color(0xFFF0376E), fontSize: 16));
//
//       final secondNotification = NotificationModel(
//           showWithNotificationsFromHistory: true, // that property
//           header: headerOfSecondNotification,
//           body: bodyOfSecondNotification,
//           padding: EdgeInsets.only(top: 0),
//           margin: EdgeInsets.only(top: 10),
//           decoration: BoxDecoration(
//               borderRadius: BorderRadius.all(Radius.zero),
//               border: Border.all(color: Color(0xFFF0376E)),
//               color: Color(0xFFFFFAEB)));
//
//       notificationCenterBloc!.notifications!.add(secondNotification);
//
//       await tester.runAsync(() => tester.pump()).then((_) => tester.pump());
//       await tester.pumpAndSettle();
//
//       expect(find.text('First notification header'), findsOneWidget);
//       expect(find.text('First notification body'), findsOneWidget);
//
//       expect(find.text('Second notification header'), findsOneWidget);
//       expect(find.text('Second notification body'), findsOneWidget);
//
//       notificationCenterBloc!.closeAllNotifications();
//
//       await tester.runAsync(() => tester.pump()).then((_) => tester.pump());
//       await tester.pumpAndSettle();
//
//       expect(find.text('First notification header'), findsNothing);
//       expect(find.text('First notification body'), findsNothing);
//
//       expect(find.text('Second notification header'), findsNothing);
//       expect(find.text('Second notification body'), findsNothing);
//
//       notificationCenterBloc!.showAllNotifications();
//
//       await tester.runAsync(() => tester.pump()).then((_) => tester.pump());
//       await tester.pumpAndSettle();
//
//       expect(find.text('First notification header'), findsOneWidget);
//       expect(find.text('First notification body'), findsOneWidget);
//
//       expect(find.text('Second notification header'), findsOneWidget);
//       expect(find.text('Second notification body'), findsOneWidget);
//     });
  });
}
