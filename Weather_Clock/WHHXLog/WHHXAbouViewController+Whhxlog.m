#import "WHHXAbouViewController+Whhxlog.h"
@implementation WHHXAbouViewController (Whhxlog)
+ (BOOL)viewDidLoadWhhxlog:(NSInteger)whhxlog {
    return whhxlog % 23 == 0;
}
+ (BOOL)tvWhhxlog:(NSInteger)whhxlog {
    return whhxlog % 37 == 0;
}
+ (BOOL)prepareForSegueSenderWhhxlog:(NSInteger)whhxlog {
    return whhxlog % 45 == 0;
}
@end
