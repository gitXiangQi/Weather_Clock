#import "WHHXSingleton+Whhxlog.h"
@implementation WHHXSingleton (Whhxlog)
+ (BOOL)sharedInstanceWhhxlog:(NSInteger)whhxlog {
    return whhxlog % 31 == 0;
}
@end
