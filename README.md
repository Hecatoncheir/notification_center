# notification_center

[![pipeline status](https://gitlab.com/Rasarts/notification_center/badges/master/pipeline.svg)](https://gitlab.com/Rasarts/notification_center/pipelines) [![coverage report](https://gitlab.com/Rasarts/notification_center/badges/master/coverage.svg)](https://gitlab.com/Rasarts/notification_center/commits/master)

### Notifications 
![Notifications preview gif](/preview/preview.gif)

### Example

```
example/lib/main.dart
```

### Use

Implement **Notification** abstract class:

```dart
abstract class Notification {}
```

Or extends **NotificationBase**:
```dart
/// NotificationBase - model with data for notification.
class NotificationBase implements Notification {
  String header;
  String body;

  NotificationBuilder<NotificationBase>? builder;
  Future<dynamic>? closeAfter;

  NotificationBase({
    required this.header,
    required this.body,
    this.builder,
    Future<dynamic>? closeAfter,
  }) : this.closeAfter = closeAfter;
}
```

Then add **NotificationCenter** widget:

```dart
class Application extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: NotificationCenter(
          alignment: Alignment.topCenter,
          notificationCenterBloc: NotificationCenterBloc(
            builders: [
              NotificationBuilder<InformationNotification>(...),
              NotificationBuilder<ErrorNotification>(...),
              NotificationBuilder<NotificationBase>(...),
              NotificationBuilder<SuccessfulNotification>(...),
            ],
          ),
          child: MyApp(),
        ),
      ),
    );
  }
}
```

Now notifications can be send:

```dart
    Future.delayed(Duration(seconds: 1), () {
      final notification = InformationNotification(
        body: 'Information notification body',
      );

      final event = NotificationAdded(
        notification: notification,
      );

      BlocProvider.of<NotificationCenterBloc>(context).add(event);
    });

    Future.delayed(Duration(seconds: 2), () {
      final notification = ErrorNotification(
        header: 'Error notification header',
        body: 'Error notification body',
        closeAfter: Duration(seconds: 1),
      );

      final event = NotificationAdded(
        notification: notification,
      );

      BlocProvider.of<NotificationCenterBloc>(context).add(event);
    });
```

or notification can have builder:

```dart

final notification = NewErrorNotification(
  header: 'New error notification header',
  body: 'New error notification body',
  closeAfter: Future.delayed(Duration(seconds: 1)),
  builder: NotificationBuilder<NewErrorNotification>(
    bodyBuilder: (bloc, notification) => Container(
        child: Column(
          childer:[
            Text(notification.header),
            Text(notification.body),
          ],
      ),
    ),
  ),
);

final event = NotificationAdded(
  notification: notification,
);

BlocProvider.of<NotificationCenterBloc>(context).add(event);
```

Events:

```dart
NotificationAdded
NotificationClosed
NotificationsOpenAll 
NotificationsCloseAll 
```