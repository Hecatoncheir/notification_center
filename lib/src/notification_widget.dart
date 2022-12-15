part of 'notification_center.dart';

class NotificationWidget extends StatefulWidget {
  final NotificationCenterBlocInterface bloc;
  final Notification notification;

  const NotificationWidget({
    super.key,
    required this.bloc,
    required this.notification,
  });

  @override
  State<NotificationWidget> createState() => _NotificationWidgetState();
}

class _NotificationWidgetState extends State<NotificationWidget> {
  late final StreamController<bool> isDismissedController;
  late final Stream<bool> isDismissedStream;

  @override
  void initState() {
    super.initState();

    isDismissedController = StreamController<bool>();
    isDismissedStream = isDismissedController.stream;
  }

  @override
  void dispose() {
    isDismissedController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: isDismissedStream,
      initialData: false,
      builder: (context, snapshot) {
        final isDismissed = snapshot.data;
        if (isDismissed == null || isDismissed) return Container();

        return Dismissible(
          key: ValueKey(widget.notification),
          onDismissed: (_) => Future(() => widget.bloc.controller().add(
                NotificationDeleted(
                  notification: widget.notification,
                ),
              )).then((value) => isDismissedController.add(true)),
          child: widget.notification,
        );
      },
    );
  }
}
