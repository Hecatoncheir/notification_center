import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:notification_center/blocs.dart' show NotificationCenterBloc;
import 'package:notification_center/notification_center.dart'
    show NotificationCenterWidget;

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

    test('can show notification with other notifications', () {});

    test('can show all notifications', () {});
    test('can hide all notifications', () {});
  });
}
