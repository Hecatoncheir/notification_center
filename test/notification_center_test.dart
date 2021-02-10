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
    testWidgets('can display main content with notification', (tester) async {
      const testText = 'Test text widget';

      final notificationCenter = NotificationCenter(
        notificationCenterBloc: NotificationCenterBloc(
          builders: [
            NotificationBuilder<NotificationBase>(
              headerBuilder: (notification) => Text(notification.header),
              bodyBuilder: (notification) => Text(notification.body),
            ),
          ],
        ),
        child: Text(testText),
      );

      await tester.pumpWidget(MaterialApp(home: notificationCenter));
      await tester.pumpAndSettle();

      expect(find.text(testText), findsOneWidget);
    });

    testWidgets('can show notification', (tester) async {
      // ignore: close_sinks
      final notificationCenterBloc = NotificationCenterBloc(
        builders: [
          NotificationBuilder<NotificationBase>(
            headerBuilder: (notification) => Text(notification.header),
            bodyBuilder: (notification) => Text(notification.body),
          ),
        ],
      );

      final notificationCenter = NotificationCenter(
        notificationCenterBloc: notificationCenterBloc,
        child: Offstage(),
      );

      await tester.pumpWidget(MaterialApp(home: notificationCenter));

      final notification = NotificationBase(
        header: 'Header',
        body: 'Body',
      );

      final event = NotificationAdded(notification: notification);
      notificationCenterBloc.add(event);

      await tester.runAsync(() => tester.pump()).then((_) => tester.pump());

      expect(find.text('Header'), findsOneWidget);
      expect(find.text('Body'), findsOneWidget);
    });

    testWidgets(
      'can show notification with other notifications',
      (tester) async {
        // ignore: close_sinks
        final notificationCenterBloc = NotificationCenterBloc(
          builders: [
            NotificationBuilder<SuccessfulNotification>(
              headerBuilder: (notification) => Container(
                width: 200,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(notification.header),
                    ),
                  ],
                ),
              ),
              bodyBuilder: (notification) => Container(
                width: 200,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(notification.body),
                    ),
                  ],
                ),
              ),
            ),
            NotificationBuilder<ErrorNotification>(
              headerBuilder: (notification) => Container(
                width: 200,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(notification.header),
                    ),
                  ],
                ),
              ),
              bodyBuilder: (notification) => Container(
                width: 200,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(notification.body),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );

        final notificationCenter = NotificationCenter(
          notificationCenterBloc: notificationCenterBloc,
          child: Offstage(),
        );

        await tester.pumpWidget(MaterialApp(home: notificationCenter));

        final firstNotification = SuccessfulNotification(
          header: 'First notification header',
          body: 'First notification body',
        );

        final firstEvent = NotificationAdded(notification: firstNotification);
        notificationCenterBloc.add(firstEvent);

        await tester.runAsync(() => tester.pump()).then((_) => tester.pump());

        expect(find.text('First notification header'), findsOneWidget);
        expect(find.text('First notification body'), findsOneWidget);

        final secondNotification = ErrorNotification(
          header: 'Second notification header',
          body: 'Second notification body',
        );

        final secondEvent = NotificationAdded(notification: secondNotification);
        notificationCenterBloc.add(secondEvent);

        await tester.runAsync(() => tester.pump()).then((_) => tester.pump());

        expect(find.text('Second notification header'), findsOneWidget);
        expect(find.text('Second notification body'), findsOneWidget);

        await tester.runAsync(() => tester.pump()).then((_) => tester.pump());

        expect(find.text('First notification header'), findsOneWidget);
        expect(find.text('First notification body'), findsOneWidget);

        expect(find.text('Second notification header'), findsOneWidget);
        expect(find.text('Second notification body'), findsOneWidget);
      },
    );

    testWidgets('can hide all notifications', (tester) async {
      // ignore: close_sinks
      final notificationCenterBloc = NotificationCenterBloc(
        builders: [
          NotificationBuilder<SuccessfulNotification>(
            headerBuilder: (notification) => Container(
              width: 200,
              child: Row(
                children: [
                  Expanded(
                    child: Text(notification.header),
                  ),
                ],
              ),
            ),
            bodyBuilder: (notification) => Container(
              width: 200,
              child: Row(
                children: [
                  Expanded(
                    child: Text(notification.body),
                  ),
                ],
              ),
            ),
          ),
          NotificationBuilder<ErrorNotification>(
            headerBuilder: (notification) => Container(
              width: 200,
              child: Row(
                children: [
                  Expanded(
                    child: Text(notification.header),
                  ),
                ],
              ),
            ),
            bodyBuilder: (notification) => Container(
              width: 200,
              child: Row(
                children: [
                  Expanded(
                    child: Text(notification.body),
                  ),
                ],
              ),
            ),
          ),
        ],
      );

      final notificationCenter = NotificationCenter(
        notificationCenterBloc: notificationCenterBloc,
        child: Offstage(),
      );

      await tester.pumpWidget(MaterialApp(home: notificationCenter));

      final firstNotification = SuccessfulNotification(
        header: 'First notification header',
        body: 'First notification body',
      );

      final firstEvent = NotificationAdded(notification: firstNotification);
      notificationCenterBloc.add(firstEvent);

      final secondNotification = ErrorNotification(
        header: 'Second notification header',
        body: 'Second notification body',
      );

      final secondEvent = NotificationAdded(notification: secondNotification);
      notificationCenterBloc.add(secondEvent);

      await tester.runAsync(() => tester.pump()).then((_) => tester.pump());

      expect(find.text('First notification header'), findsOneWidget);
      expect(find.text('First notification body'), findsOneWidget);

      expect(find.text('Second notification header'), findsOneWidget);
      expect(find.text('Second notification body'), findsOneWidget);

      notificationCenterBloc.add(NotificationsCloseAll());

      await tester.runAsync(() => tester.pump()).then((_) => tester.pump());

      expect(find.text('First notification header'), findsNothing);
      expect(find.text('First notification body'), findsNothing);

      expect(find.text('Second notification header'), findsNothing);
      expect(find.text('Second notification body'), findsNothing);
    });

    testWidgets('can show all notifications', (tester) async {
      // ignore: close_sinks
      final notificationCenterBloc = NotificationCenterBloc(
        builders: [
          NotificationBuilder<SuccessfulNotification>(
            headerBuilder: (notification) => Container(
              width: 200,
              child: Row(
                children: [
                  Expanded(
                    child: Text(notification.header),
                  ),
                ],
              ),
            ),
            bodyBuilder: (notification) => Container(
              width: 200,
              child: Row(
                children: [
                  Expanded(
                    child: Text(notification.body),
                  ),
                ],
              ),
            ),
          ),
          NotificationBuilder<ErrorNotification>(
            headerBuilder: (notification) => Container(
              width: 200,
              child: Row(
                children: [
                  Expanded(
                    child: Text(notification.header),
                  ),
                ],
              ),
            ),
            bodyBuilder: (notification) => Container(
              width: 200,
              child: Row(
                children: [
                  Expanded(
                    child: Text(notification.body),
                  ),
                ],
              ),
            ),
          ),
        ],
      );

      final notificationCenter = NotificationCenter(
        notificationCenterBloc: notificationCenterBloc,
        child: Offstage(),
      );

      await tester.pumpWidget(MaterialApp(home: notificationCenter));

      final firstNotification = SuccessfulNotification(
        header: 'First notification header',
        body: 'First notification body',
      );

      final firstEvent = NotificationAdded(notification: firstNotification);
      notificationCenterBloc.add(firstEvent);

      final secondNotification = ErrorNotification(
        header: 'Second notification header',
        body: 'Second notification body',
      );

      final secondEvent = NotificationAdded(notification: secondNotification);
      notificationCenterBloc.add(secondEvent);

      await tester.runAsync(() => tester.pump()).then((_) => tester.pump());

      expect(find.text('First notification header'), findsOneWidget);
      expect(find.text('First notification body'), findsOneWidget);

      expect(find.text('Second notification header'), findsOneWidget);
      expect(find.text('Second notification body'), findsOneWidget);

      notificationCenterBloc.add(NotificationsCloseAll());
      await tester.runAsync(() => tester.pump()).then((_) => tester.pump());

      expect(find.text('First notification header'), findsNothing);
      expect(find.text('First notification body'), findsNothing);

      expect(find.text('Second notification header'), findsNothing);
      expect(find.text('Second notification body'), findsNothing);

      notificationCenterBloc.add(NotificationsOpenAll());
      await tester.runAsync(() => tester.pump()).then((_) => tester.pump());

      expect(find.text('First notification header'), findsOneWidget);
      expect(find.text('First notification body'), findsOneWidget);

      expect(find.text('Second notification header'), findsOneWidget);
      expect(find.text('Second notification body'), findsOneWidget);
    });
  });
}
