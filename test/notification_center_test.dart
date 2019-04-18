import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:notification_center/blocs.dart' show NotificationCenterBloc;
import 'package:notification_center/notification_center.dart'
    show NotificationCenterWidget;

void main() {
  group('Notification center', () {
    NotificationCenterBloc notificationCenterBloc;
    Widget notificationCenter;

    setUp(() {
      notificationCenterBloc = NotificationCenterBloc();
      notificationCenter = NotificationCenterWidget(
          notificationCenterBloc: notificationCenterBloc);
    });

    tearDown(() {
      notificationCenterBloc.dispose();
    });

    test('can display main content with notification', () {});
    test('can show notification with other notifications', () {});
    test('can show all notifications', () {});
    test('can hide all notifications', () {});
  });
}
