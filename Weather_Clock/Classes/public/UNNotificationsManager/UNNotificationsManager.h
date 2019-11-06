#import <Foundation/Foundation.h>
#import <UserNotifications/UserNotifications.h>
#define categryLaterIdf @"categryIdsdfentiferLater"
#define categryStopIdf @"categryIdewerwrntiferStop"
#define actionFiveMin @"xqfiveMrginete"
#define actionHalfAnHour @"halwefAnHour"
#define actionOneHour @"onefdHour"
#define actionStop @"stopCanrtrcel"
extern NSString * const UNDidReciveRemoteNotifationKey;
extern NSString * const UNDidReciveLocalNotifationKey;
extern NSString * const UNNotifationInfoIdentiferKey;
@interface UNNotificationsManager : NSObject
+ (instancetype)shared;
+ (void)registerLocalNotification API_AVAILABLE(ios(10.0));
#pragma mark -- AddNotification
+ (void)addNotificationWithWHHXRequest:(UNNotificationRequest *)requst
                  completionHanler:(void(^)(NSError *error))handler API_AVAILABLE(ios(10.0));
+ (void)addNotificationWithRequest:(UNNotificationRequest *)requst
                  completionHanler:(void(^)(NSError *error))handler API_AVAILABLE(ios(10.0));
+ (void)addNotificationWithContent:(UNNotificationContent *)content
                         identifer:(NSString *)identifer
                           trigger:(UNNotificationTrigger *)trigger
                  completionHanler:(void(^)(NSError *error))handler API_AVAILABLE(ios(10.0));
+ (void)addNotificationWithContent:(UNNotificationContent *)content
                          interval:(NSTimeInterval)interval
                         identifer:(NSString *)identifer
                          isRepeat:(BOOL)repeat
                  completionHanler:(void(^)(NSError *error))handler API_AVAILABLE(ios(10.0));
+ (void)addNotificationWHHXWithContent:(UNNotificationContent *)content
                          interval:(NSTimeInterval)interval
                         identifer:(NSString *)identifer
                          isRepeat:(BOOL)repeat
                  completionHanler:(void(^)(NSError *error))handler API_AVAILABLE(ios(10.0));
+ (void)addNotificationWithContent:(UNNotificationContent *)content
                    dateComponents:(NSDateComponents *)components
                         identifer:(NSString *)identifer
                          isRepeat:(BOOL)repeat
                  completionHanler:(void(^)(NSError *error))handler API_AVAILABLE(ios(10.0));
+ (void)addNotificationWithContent:(UNNotificationContent *)content
                           weekDay:(NSInteger)weekDay
                              date:(NSDate *)date
                         identifer:(NSString *)identifer
                          isRepeat:(BOOL)repeat
                  completionHanler:(void(^)(NSError *error))handler API_AVAILABLE(ios(10.0));
+ (void)addNotificationWithBody:(NSString *)body
                          title:(NSString *)title
                       subTitle:(NSString *)subTitle
                        weekDay:(NSInteger)weekDay
                           date:(NSDate *)date
                          music:(NSString *)music
                      identifer:(NSString *)identifer
                       isRepeat:(BOOL)repeat
               completionHanler:(void (^)(NSError *error))handler API_AVAILABLE(ios(10.0));
+ (void)addNotificationWHHXWithBody:(NSString *)body
                          title:(NSString *)title
                       subTitle:(NSString *)subTitle
                        weekDay:(NSInteger)weekDay
                           date:(NSDate *)date
                          music:(NSString *)music
                      identifer:(NSString *)identifer
                       isRepeat:(BOOL)repeat
               completionHanler:(void (^)(NSError *error))handler API_AVAILABLE(ios(10.0));
+ (void)addRepeatEveryDayNotificationWithBody:(NSString *)body
                                        title:(NSString *)title
                                     subTitle:(NSString *)subTitle
                                         date:(NSDate *)date
                                        music:(NSString *)music
                                    identifer:(NSString *)identifer
                             completionHanler:(void (^)(NSError *error))handler API_AVAILABLE(ios(10.0));
+ (void)addComponentsNotificationWithBody:(NSString *)body
                                    title:(NSString *)title
                                 subTitle:(NSString *)subTitle
                           dateComponents:(NSDateComponents *)components
                                    music:(NSString *)music
                                identifer:(NSString *)identifer
                                 isRepeat:(BOOL)repeat
                         completionHanler:(void (^)(NSError *error))handler API_AVAILABLE(ios(10.0));
#pragma mark -- NotificationManage
+ (void)removeAllNotification;
+ (void)removeWHHXAllNotification;
+ (void)removeNotificationWithIdentifer:(NSString *)identifer;
+ (void)removeNotificationWithIdentifers:(NSArray<NSString *> *)identifers;
+ (void)notificationIsExitWithIdentifer:(NSString *)identifer completion:(void(^)(BOOL isExit))completion;
+ (void)notificationIsExitWithWHHXIdentifer:(NSString *)identifer completion:(void(^)(BOOL isExit))completion;
+ (void)getAllNotificationIdentiferBlock:(void(^)(NSArray <NSString *>*identifers))idBlock;
+ (void)getDeliveredNotificationIdentiferBlock:(void(^)(NSArray <NSString *>*identifers))idBlock;
+ (void)getPendingNotificationIdentiferBlock:(void(^)(NSArray <NSString *>*identifers))idBlock;
#pragma mark -- NSDateComponents
+ (NSDateComponents *)componentsWithDate:(NSDate *)date;
+ (NSDateComponents *)componentsWithDate:(NSDate *)date weekday:(NSInteger)weekday;
+ (NSDateComponents *)componentsWithWHHXDate:(NSDate *)date weekday:(NSInteger)weekday;
+ (NSDateComponents *)componentsEveryDayWithDate:(NSDate *)date;
+ (NSDateComponents *)componentsEveryWeekWithDate:(NSDate *)date;
+ (NSDateComponents *)componentsEveryMonthWithDate:(NSDate *)date;
+ (NSDateComponents *)componentsEveryYearWithDate:(NSDate *)date;
#pragma mark -- UNNotificationContent
+ (UNMutableNotificationContent *)contentWithTitle:(NSString *)title
                                   subTitle:(NSString *)subTitle
                                              body:(NSString *)body API_AVAILABLE(ios(10.0));
+ (UNMutableNotificationContent *)contentWithWHHXTitle:(NSString *)title
                                          subTitle:(NSString *)subTitle
                                              body:(NSString *)body API_AVAILABLE(ios(10.0));
+ (UNMutableNotificationContent *)contentWithTitle:(NSString *)title
                                   subTitle:(NSString *)subTitle
                                       body:(NSString *)body
                                             badge:(NSInteger)badge API_AVAILABLE(ios(10.0));
+ (UNMutableNotificationContent *)contentWithTitle:(NSString *)title
                                   subTitle:(NSString *)subTitle
                                       body:(NSString *)body
                                             sound:(UNNotificationSound *)sound API_AVAILABLE(ios(10.0));
+ (UNMutableNotificationContent *)contentWithTitle:(NSString *)title
                                   subTitle:(NSString *)subTitle
                                       body:(NSString *)body
                                      badge:(NSInteger)badge
                                             sound:(UNNotificationSound *)sound API_AVAILABLE(ios(10.0));
+ (UNMutableNotificationContent *)contentWithTitle:(NSString *)title
                                   subTitle:(NSString *)subTitle
                                       body:(NSString *)body
                                      badge:(NSInteger)badge
                                      sound:(UNNotificationSound *)sound
                                        attachment:(UNNotificationAttachment *)attachment API_AVAILABLE(ios(10.0));
+ (UNMutableNotificationContent *)contentWithTitle:(NSString *)title
                                   subTitle:(NSString *)subTitle
                                       body:(NSString *)body
                                      badge:(NSInteger)badge
                                      sound:(UNNotificationSound *)sound
                                       attachments:(NSArray <UNNotificationAttachment *> *)attachments API_AVAILABLE(ios(10.0));
+ (UNMutableNotificationContent *)contentWithWHHXTitle:(NSString *)title
                                          subTitle:(NSString *)subTitle
                                              body:(NSString *)body
                                             badge:(NSInteger)badge
                                             sound:(UNNotificationSound *)sound
                                       attachments:(NSArray <UNNotificationAttachment *> *)attachments API_AVAILABLE(ios(10.0));
#pragma mark -- UNNotificationTrigger
+ (UNNotificationTrigger *)triggerWithTimeInterval:(NSTimeInterval)interval repeats:(BOOL)repeats API_AVAILABLE(ios(10.0));
+ (UNNotificationTrigger *)triggerWithDateComponents:(NSDateComponents *)components repeats:(BOOL)repeats API_AVAILABLE(ios(10.0));
+ (UNNotificationTrigger *)triggerWithRegion:(CLRegion *)Region repeats:(BOOL)repeats API_AVAILABLE(ios(10.0));
#pragma mark -- UNNotificationSound
+ (UNNotificationSound *)soundWithName:(NSString *)name API_AVAILABLE(ios(10.0));
+ (UNNotificationSound *)soundWithWHHXName:(NSString *)name API_AVAILABLE(ios(10.0));
@end
