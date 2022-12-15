library notification_center;

import 'dart:async';

import 'package:flutter/material.dart' hide Notification;

import 'bloc/notification_center_bloc.dart';
import 'notifications/notification.dart';

part 'notification_widget.dart';

class NotificationCenter extends StatefulWidget {
  final Widget? child;
  final NotificationCenterBlocInterface? bloc;

  final Alignment alignment;

  const NotificationCenter({
    super.key,
    this.child,
    this.bloc,
    this.alignment = Alignment.bottomRight,
  });

  @override
  State<NotificationCenter> createState() => NotificationCenterState();

  static NotificationCenterState of(BuildContext context) {
    final state = context.findAncestorStateOfType<NotificationCenterState>();
    if (state == null) throw Exception("NotificationCenterState not found.");
    return state;
  }
}

class NotificationCenterState extends State<NotificationCenter> {
  late final NotificationCenterBlocInterface _bloc;

  Future<List<Notification>> getAllNotifications() async {
    _bloc.controller().add(const GetAllNotifications());
    return _bloc
        .stream()
        .firstWhere((state) => state is AllNotifications)
        .then((state) => (state as AllNotifications).notifications);
  }

  Future<void> showAllNotifications() async {
    _bloc.controller().add(const ShowAllNotifications());
  }

  Future<void> hideAllNotifications() async {
    _bloc.controller().add(const HideAllNotifications());
  }

  Future<void> showNotification(Notification notification) async {
    _bloc.controller().add(ShowNotification(notification: notification));
  }

  Future<void> hideNotification(Notification notification) async {
    _bloc.controller().add(HideNotification(notification: notification));
  }

  @override
  void initState() {
    super.initState();

    _bloc = widget.bloc ?? NotificationCenterBloc();
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final notifications = <Notification>[];

    return Stack(
      children: [
        widget.child ?? Container(),
        StreamBuilder<NotificationCenterBlocState>(
          stream: _bloc.stream().where(
                (state) =>
                    state is ShowNotificationBegin ||
                    state is ShowNotificationEnd ||
                    state is NotificationDeletedSuccessful ||
                    state is ShowAllNotificationsBegin ||
                    state is ShowAllNotificationsEnd,
              ),
          builder: (context, snapshot) {
            final state = snapshot.data;
            if (state == null) return Container();

            if (state is ShowNotificationBegin) {
              notifications
                ..clear()
                ..add(state.notification);
            }

            if (state is ShowNotificationEnd) {
              notifications.remove(state.notification);
            }

            if (state is NotificationDeletedSuccessful) {
              notifications.remove(state.notification);
            }

            if (state is ShowAllNotificationsBegin) {
              notifications
                ..clear()
                ..addAll(state.notifications);
            }

            if (state is ShowAllNotificationsEnd) {
              notifications.clear();
            }

            double? width;
            for (final notification in notifications) {
              final notificationWidth = notification.constraints?.maxWidth;

              if (notificationWidth == null) {
                width = double.infinity;
                break;
              }

              width ??= notificationWidth;
              if (width < notificationWidth) width = notificationWidth;
            }

            return Align(
              alignment: widget.alignment,
              child: SizedBox(
                width: width,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 3),
                      for (final notification in notifications)
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 3,
                            horizontal: 6,
                          ),
                          child: NotificationWidget(
                            key: ValueKey(notification),
                            bloc: _bloc,
                            notification: notification,
                          ),
                        ),
                      const SizedBox(height: 3),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
