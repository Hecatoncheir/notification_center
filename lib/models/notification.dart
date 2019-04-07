class NotificationModel {
  NotificationHeader header;
  NotificationBody body;

  bool onlyOneNotificationShow;

  NotificationModel(
      {this.header, this.body, this.onlyOneNotificationShow = false});
}

class NotificationHeader {
  String text;
  NotificationHeader(this.text);
}

class NotificationBody {
  String text;
  NotificationBody(this.text);
}
