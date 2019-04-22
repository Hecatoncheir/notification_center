import 'package:flutter/material.dart' hide Notification;
import 'package:flutter_test/flutter_test.dart';

import 'package:notification_center/blocs.dart' show NotificationCenterBloc;
import 'package:notification_center/models.dart';
import 'package:notification_center/notification_center.dart'
    show NotificationCenterWidget;

import 'package:notification_center/models.dart' show NotificationModel;

void main() {
  group('Notification center', () {
    NotificationCenterBloc notificationCenterBloc;

    setUp(() {
      notificationCenterBloc = NotificationCenterBloc();
    });

    tearDown(() {
      notificationCenterBloc.dispose();
    });

    testWidgets('can display main content with notification', (tester) async {
      Widget notificationCenter;

      const testText = 'Test text widget';
      notificationCenter = NotificationCenterWidget(
          notificationCenterBloc: notificationCenterBloc,
          child: Text(testText));

      await tester.pumpWidget(MaterialApp(home: notificationCenter));

      expect(find.text(testText), findsOneWidget);
    });

    testWidgets('can show notification', (tester) async {
      Widget notificationCenter;

      notificationCenter = NotificationCenterWidget(
          notificationCenterBloc: notificationCenterBloc, child: Offstage());

      await tester.pumpWidget(MaterialApp(home: notificationCenter));

      final notification = NotificationModel(
          header: NotificationHeaderModel(text: 'Header'),
          body: NotificationBodyModel(text: 'Body'));

      notificationCenterBloc.notifications.add(notification);

      await tester.runAsync(() => tester.pump());
      await tester.pump();
      await tester.pumpAndSettle(Duration(seconds: 3));
      await tester.idle();

      expect(find.text('Header'), findsOneWidget);
      expect(find.text('Body'), findsOneWidget);
    });

    test('can show notification with other notifications', () {
      final firstNotification = NotificationModel(
          showWithNotificationsFromHistory: true,
          decoration: BoxDecoration(
              color: Color(0xFFfecfbf),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: Color(0xFFb7315c))),
          margin: EdgeInsets.all(3),
          padding: EdgeInsets.all(2),
          header: NotificationHeaderModel(
              padding: EdgeInsets.only(top: 10, left: 10, bottom: 2, right: 10),
              text: 'Notification header',
              textStyle: TextStyle(
                  color: Color(0xFFb7315c),
                  fontSize: 16,
                  fontWeight: FontWeight.bold)),
          body: NotificationBodyModel(
              padding: EdgeInsets.only(top: 5, left: 10, bottom: 10, right: 10),
              textStyle: TextStyle(color: Color(0xFFb7315c)),
              text: 'Notification body'));
    });

    test('can show all notifications', () {});

    test('can hide all notifications', () {});
  });
}
