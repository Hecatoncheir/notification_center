#import "NotificationCenterPlugin.h"
#import <notification_center/notification_center-Swift.h>

@implementation NotificationCenterPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftNotificationCenterPlugin registerWithRegistrar:registrar];
}
@end
