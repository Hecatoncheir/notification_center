import 'package:flutter/material.dart' hide Notification;
import 'package:flutter_test/flutter_test.dart';
import 'package:notification_center/notification_center.dart';

void main() {
  group('Notification center', () {
    testWidgets('can display main content with notification', (tester) async {
      const testWidget = NotificationCenter(
        child: Text('Test text widget'),
      );

      const widget = MaterialApp(
        home: testWidget,
      );

      await tester.pumpWidget(widget);
      await tester.pump();

      expect(find.text('Test text widget'), findsOneWidget);
    });

    testWidgets('can show notification', (tester) async {
      final bloc = NotificationCenterBloc();

      final testWidget = NotificationCenter(
        bloc: bloc,
        child: const Text(
          'Test text widget',
        ),
      );

      final widget = MaterialApp(
        home: testWidget,
      );

      await tester.pumpWidget(widget);

      expect(find.text('Notification header'), findsNothing);
      expect(find.text('Notification body'), findsNothing);

      const notification = Notification(
        headerText: "Notification header",
        bodyText: "Notification body",
        duration: Duration(seconds: 2),
      );

      bloc.controller().add(const ShowNotification(notification: notification));

      await tester.pump(const Duration(seconds: 1));

      expect(find.text('Notification header'), findsOneWidget);
      expect(find.text('Notification body'), findsOneWidget);

      await tester.pump(const Duration(seconds: 1));

      expect(find.text('Notification header'), findsNothing);
      expect(find.text('Notification body'), findsNothing);
    });

    testWidgets('can show all notifications', (tester) async {
      final bloc = NotificationCenterBloc();

      final testWidget = NotificationCenter(
        bloc: bloc,
        child: const Text(
          'Test text widget',
        ),
      );

      final widget = MaterialApp(
        home: testWidget,
      );

      await tester.pumpWidget(widget);

      expect(find.text('First notification header'), findsNothing);
      expect(find.text('First notification body'), findsNothing);

      const firstNotification = Notification(
        headerText: "First notification header",
        bodyText: "First notification body",
        duration: Duration(seconds: 2),
      );

      bloc
          .controller()
          .add(const ShowNotification(notification: firstNotification));

      await tester.pump(const Duration(seconds: 1));

      expect(find.text('First notification header'), findsOneWidget);
      expect(find.text('First notification body'), findsOneWidget);

      await tester.pump(const Duration(seconds: 1));

      expect(find.text('First notification header'), findsNothing);
      expect(find.text('First notification body'), findsNothing);

      const secondNotification = Notification(
        headerText: "Second notification header",
        bodyText: "Second notification body",
        duration: Duration(seconds: 2),
      );

      bloc
          .controller()
          .add(const ShowNotification(notification: secondNotification));

      await tester.pump(const Duration(seconds: 1));

      expect(find.text('Second notification header'), findsOneWidget);
      expect(find.text('Second notification body'), findsOneWidget);

      await tester.pump(const Duration(seconds: 1));

      expect(find.text('Second notification header'), findsNothing);
      expect(find.text('Second notification body'), findsNothing);

      await tester.pump(const Duration(seconds: 1));

      bloc.controller().add(const ShowAllNotifications());
      await tester.pump(const Duration(seconds: 1));

      expect(find.text('First notification header'), findsOneWidget);
      expect(find.text('First notification body'), findsOneWidget);

      expect(find.text('Second notification header'), findsOneWidget);
      expect(find.text('Second notification body'), findsOneWidget);
    });
  });
}
