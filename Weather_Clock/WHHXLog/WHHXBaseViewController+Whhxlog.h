#import <UIKit/UIKit.h>
#import "WHHXBaseViewController.h"
@interface WHHXBaseViewController (Whhxlog)
+ (BOOL)viewDidLoadWhhxlog:(NSInteger)whhxlog;
+ (BOOL)printStackInfoWhhxlog:(NSInteger)whhxlog;
+ (BOOL)testMomoryLeakWhhxlog:(NSInteger)whhxlog;
+ (BOOL)calculateCycleTimeWhhxlog:(NSInteger)whhxlog;
+ (BOOL)prepareForSegueSenderWhhxlog:(NSInteger)whhxlog;
@end
