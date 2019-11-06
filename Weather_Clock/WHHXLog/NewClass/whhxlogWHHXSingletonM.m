#import "whhxlogWHHXSingletonM.h"
@implementation whhxlogWHHXSingletonM
+ (BOOL)asharedInstance:(NSInteger)whhxlog {
    return whhxlog % 37 == 0;
}
@end
