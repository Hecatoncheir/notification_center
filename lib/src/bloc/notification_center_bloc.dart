import 'dart:async';
import 'package:meta/meta.dart';

import 'package:bloc/bloc.dart';
import 'package:notification_center/models/notification.dart';

import 'package:notification_center/models/notification_group.dart';
import 'package:notification_center/models/notification_with_group.dart';

part 'notification_center_event.dart';
part 'notification_center_state.dart';

class NotificationCenterBloc
    extends Bloc<NotificationCenterEvent, NotificationCenterState> {
  final List<NotificationGroup> groups;
  final List<NotificationWithGroup> notificationsForRender;

  NotificationCenterBloc({
    required this.groups,
    this.notificationsForRender = const <NotificationWithGroup>[],
  }) : super(NotificationCenterInitial());

  @override
  Stream<NotificationCenterState> mapEventToState(
    NotificationCenterEvent event,
  ) async* {
    if (event is NotificationAdded) {
      final notification = event.notification;

      NotificationGroup? notificationGroup;
      for (final group in groups) {
        if (group.type == notification.runtimeType) {
          notificationGroup = group;
          break;
        }
      }

      if (notificationGroup == null) return;

      final notificationWithGroup = NotificationWithGroup(
        notification: notification,
        group: notificationGroup,
      );

      notificationsForRender.add(notificationWithGroup);

      final closeNotificationAfterDuration = notification.closeAfter;
      if (closeNotificationAfterDuration != null) {
        Future.delayed(closeNotificationAfterDuration, () {
          notificationsForRender.remove(notificationWithGroup);
          yield NotificationsReadyForRender(
            notificationsForRender: notificationsForRender,
          );
        });
      }

      yield NotificationsReadyForRender(
        notificationsForRender: notificationsForRender,
      );
    }
  }
}
