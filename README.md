# notification_center

[![pipeline status](https://gitlab.com/Rasarts/notification_center/badges/master/pipeline.svg)](https://gitlab.com/Rasarts/notification_center/pipelines) [![coverage report](https://gitlab.com/Rasarts/notification_center/badges/master/coverage.svg)](https://gitlab.com/Rasarts/notification_center/commits/master)

### Notifications 
![Notifications preview gif](/preview/preview.gif)

### Example

```
example/lib/main.dart
```

### How to use

Add **NotificationCenter** widget:

```dart
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: NotificationCenter(
          child: ExampleWidget(),
        ),
      ),
    );
  }
```

Now notifications can be send:

```dart
  @override
  void initState() {
    super.initState();
    
    final infoNotification = Info(
      headerText: "Info notification header",
      bodyText: "Info notification body",
      constraints: BoxConstraints(maxWidth: 260),
      notificationBuilder: notificationFadeAnimationBuilder,
    );
    
    NotificationCenter.of(context).showNotification(infoNotification);
  }
```

Animations:

```
notificationFadeAnimationBuilder,
notificationOneByOneAnimationBuilder,
```

BLoC events:

```
GetAllNotifications,
ShowAllNotifications,
HideAllNotifications,
ShowNotification,
HideNotification,
NotificationDeleted,
```