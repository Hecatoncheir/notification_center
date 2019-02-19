import 'package:flutter_test/flutter_test.dart';

import 'package:notification_center/blocs.dart' show NotificationCenterBloc;
import 'package:notification_center/notification_center.dart'
    show NotificationCenter;

void main() {
  group('NotificationCenter', () {
    NotificationCenterBloc notificationCenterBloc;
    NotificationCenter notificationCenter;

    setUp(() {
      notificationCenterBloc = NotificationCenterBloc();
      notificationCenter =
          NotificationCenter(notificationCenterBloc: notificationCenterBloc);
    });

    testWidgets('can show children', (tester) async {});
    testWidgets('can show notification', (tester) async {});
  });
}
