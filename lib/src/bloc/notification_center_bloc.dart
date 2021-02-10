import 'dart:async';
import 'package:meta/meta.dart';

import 'package:bloc/bloc.dart';
import 'package:notification_center/models/interface.dart';

import 'package:notification_center/models/notification_builder.dart';
import 'package:notification_center/models/notification_with_builder.dart';

part 'notification_center_event.dart';
part 'notification_center_state.dart';

/// NotificationCenterBloc - logic of notification show/hide, hold history.
class NotificationCenterBloc
    extends Bloc<NotificationCenterEvent, NotificationCenterState> {
  final List<NotificationBuilder> builders;

  List<NotificationWithBuilder>? notificationsForRender;
  List<NotificationWithBuilder>? stash;

  NotificationCenterBloc({
    required this.builders,
    this.notificationsForRender,
    this.stash,
  }) : super(NotificationCenterInitial()) {
    notificationsForRender ??= <NotificationWithBuilder>[];
    stash ??= <NotificationWithBuilder>[];

    if (notificationsForRender!.isNotEmpty) {
      for (final notification in notificationsForRender!) {
        final event = NotificationAdded(
          notification: notification.notification,
        );
        add(event);
      }
    }
  }

  @override
  Stream<NotificationCenterState> mapEventToState(
    NotificationCenterEvent event,
  ) async* {
    if (event is NotificationAdded) {
      final notification = event.notification;

      NotificationBuilder? notificationGroup;
      for (final group in builders) {
        if (group.type == notification.runtimeType) {
          notificationGroup = group;
          break;
        }
      }

      if (notificationGroup == null) return;

      final notificationWithGroup = NotificationWithBuilder(
        notification: notification,
        builder: notificationGroup,
      );

      notificationsForRender!.add(notificationWithGroup);
      stash!.add(notificationWithGroup);

      final closeNotificationAfterDuration = notification.closeAfter;
      if (closeNotificationAfterDuration != null) {
        Future.delayed(closeNotificationAfterDuration, () {
          add(NotificationClosed(notification: notification));
        });
      }

      yield NotificationsReadyForRender(
        notificationsForRender: notificationsForRender!,
        allNotifications: stash!,
      );
    }

    if (event is NotificationClosed) {
      NotificationWithBuilder? notification;
      for (final notificationForRender in notificationsForRender!) {
        if (notificationForRender.notification == event.notification) {
          notification = notificationForRender;
          break;
        }
      }

      if (notification == null) return;

      notificationsForRender!.remove(notification);

      yield NotificationsReadyForRender(
        notificationsForRender: notificationsForRender!,
        allNotifications: stash!,
      );
    }

    if (event is NotificationsOpenAll) {
      notificationsForRender!.clear();
      notificationsForRender!.addAll(stash!);
      yield NotificationsReadyForRender(
        notificationsForRender: notificationsForRender!,
        allNotifications: stash!,
      );
    }

    if (event is NotificationsCloseAll) {
      notificationsForRender!.clear();

      yield NotificationsReadyForRender(
        notificationsForRender: notificationsForRender!,
        allNotifications: stash!,
      );
    }
  }
}
