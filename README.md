# notification_center

[![pipeline status](https://gitlab.com/Rasarts/notification_center/badges/master/pipeline.svg)](https://gitlab.com/Rasarts/notification_center/pipelines)


### Notifications 
![Notifications preview gif](/preview/preview.gif)

## Getting Started


Make NotificationCenterWidget with NotificationCenterBloc:

```dart
  NotificationCenterBloc notificationCenterBloc = NotificationCenterBloc();
```

```dart
/// NotificationCenter
child: NotificationCenterWidget(
  notificationCenterBloc: notificationCenterBloc,
  child: someWidget),
```

For show some notification they must be created:

```dart
import 'package:notification_center/models.dart'
    show NotificationModel, NotificationHeaderModel, NotificationBodyModel;

import 'package:notification_center/animations.dart'
    show oneByOneHeaderAnimation, oneByOneBodyAnimation;
```

```dart
final header = NotificationHeaderModel(
    text: 'Fourth notification header',
    animator: oneByOneHeaderAnimation,
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(color: Color(0xFFFFE0B4)),
    textStyle: TextStyle(color: Color(0xFFA34F73), fontSize: 18));

final body = NotificationBodyModel(
    text: 'Fourth notification body',
    animator: oneByOneBodyAnimation,
    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
    textStyle: TextStyle(color: Color(0xFFF0376E), fontSize: 16));

final notification = NotificationModel(
    header: header,
    body: body,
    padding: EdgeInsets.only(top: 0),
    margin: EdgeInsets.only(top: 10),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.zero),
        border: Border.all(color: Color(0xFFF0376E)),
        color: Color(0xFFFFFAEB)));
```

and added to notificationCenterBloc:
``` dart
notificationCenterBloc.notifications.add(notification);
```

For show notification with other use showWithNotificationsFromHistory property:
``` dart

  /// Constructor.
  NotificationModel(
      {this.header,
      this.body,
      this.margin = const EdgeInsets.all(8),
      this.padding = const EdgeInsets.all(6),
      this.animator = fadeInAnimation,
      this.decoration,
  this.showWithNotificationsFromHistory = false});
```


For hide all notifications call:
```dart
notificationCenterBloc.closeAllNotifications(),
```

For show all notifications call:
```dart
notificationCenterBloc.showAllNotifications()
```
