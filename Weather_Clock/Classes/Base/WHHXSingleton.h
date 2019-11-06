#import <Foundation/Foundation.h>
@class BirthdayCellModel;
@interface WHHXSingleton : NSObject
@property (nonatomic, strong) NSMutableArray<BirthdayCellModel *> *birthdayInfo;
+ (instancetype)sharedInstance;
@end
