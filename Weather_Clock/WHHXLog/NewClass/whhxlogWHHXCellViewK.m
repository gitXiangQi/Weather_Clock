#import "whhxlogWHHXCellViewK.h"
@implementation whhxlogWHHXCellViewK
+ (BOOL)NSetmodel:(NSInteger)whhxlog {
    return whhxlog % 7 == 0;
}
+ (BOOL)RSetimage:(NSInteger)whhxlog {
    return whhxlog % 29 == 0;
}
+ (BOOL)uSetconstellationdata:(NSInteger)whhxlog {
    return whhxlog % 30 == 0;
}
@end
