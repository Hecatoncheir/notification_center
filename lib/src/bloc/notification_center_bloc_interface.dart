part of 'notification_center_bloc.dart';

abstract class NotificationCenterBlocInterface {
  StreamController<NotificationCenterBlocEvent> controller();
  Stream<NotificationCenterBlocState> stream();
  void dispose();
}
