#import "WHHXAppDelegate.h"
#import "UNNotificationsManager.h"
#import "WHHXBaseTabBarController.h"
#import "WHHXSingleton.h"
@interface WHHXAppDelegate ()
@end
@implementation WHHXAppDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound categories:nil];
    [application registerUserNotificationSettings:settings];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *birthdayData = [defaults objectForKey:@"birthdayInfoList"];
    if (birthdayData == nil) {
        WHHXSingleton.sharedInstance.birthdayInfo = [NSMutableArray array];
    } else {
        WHHXSingleton.sharedInstance.birthdayInfo = (NSMutableArray<BirthdayCellModel *> *)[NSKeyedUnarchiver unarchiveObjectWithData:birthdayData];
    }
    if (@available(iOS 10.0, *)) {
        [UNNotificationsManager registerLocalNotification];
    }
    [self showWindow];
    return YES;
}
- (void)showWindow {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    WHHXBaseTabBarController *tabBarVc = [[WHHXBaseTabBarController alloc] init];
    self.window.rootViewController = tabBarVc;
    [self.window makeKeyAndVisible];
}
- (void)applicationWillResignActive:(UIApplication *)application {
}
- (void)applicationDidEnterBackground:(UIApplication *)application {
    NSData *encodedBirthdayInfo = [NSKeyedArchiver archivedDataWithRootObject:WHHXSingleton.sharedInstance.birthdayInfo];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:encodedBirthdayInfo forKey:@"birthdayInfoList"];
}
- (void)applicationWillEnterForeground:(UIApplication *)application {
}
- (void)applicationDidBecomeActive:(UIApplication *)application {
    application.applicationIconBadgeNumber = 0;
}
- (void)applicationWillTerminate:(UIApplication *)application {
    NSData *encodedBirthdayInfo = [NSKeyedArchiver archivedDataWithRootObject:WHHXSingleton.sharedInstance.birthdayInfo];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:encodedBirthdayInfo forKey:@"birthdayInfoList"];
}
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    application.applicationIconBadgeNumber = 0;
}
@end
