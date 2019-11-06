#import "WHHXCellView+Whhxlog.h"
@implementation WHHXCellView (Whhxlog)
+ (BOOL)setModelWhhxlog:(NSInteger)whhxlog {
    return whhxlog % 17 == 0;
}
+ (BOOL)setImageWhhxlog:(NSInteger)whhxlog {
    return whhxlog % 33 == 0;
}
+ (BOOL)setConstellationDataWhhxlog:(NSInteger)whhxlog {
    return whhxlog % 18 == 0;
}
@end
