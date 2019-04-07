import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:notification_center/notification_center.dart';

void main() {
  const MethodChannel channel = MethodChannel('notification_center');

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
//    expect(await NotificationCenter.platformVersion, '42');
  });
}
