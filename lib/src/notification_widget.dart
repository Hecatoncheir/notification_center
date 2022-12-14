part of 'notification_center.dart';

class NotificationWidget extends StatelessWidget {
  final NotificationCenterBlocInterface bloc;
  final Notification notification;
  final bool mustBeDismissible;

  const NotificationWidget({
    super.key,
    required this.bloc,
    required this.notification,
    this.mustBeDismissible = false,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: notification.alignment,
      child: notification.isDismissible || mustBeDismissible
          ? Dismissible(
              key: ValueKey(notification),
              onDismissed: (_) => bloc.controller().add(
                    NotificationDeleted(
                      notification: notification,
                    ),
                  ),
              child: notification,
            )
          : notification,
    );
  }
}
