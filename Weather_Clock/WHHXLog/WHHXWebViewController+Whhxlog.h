#import "WHHXBaseViewController.h"
#import "WHHXWebViewController.h"
#import "Masonry.h"
#import "WHToast.h"
@interface WHHXWebViewController (Whhxlog)
+ (BOOL)viewDidLoadWhhxlog:(NSInteger)whhxlog;
+ (BOOL)webViewDidStartLoadWhhxlog:(NSInteger)whhxlog;
+ (BOOL)webViewDidFinishLoadWhhxlog:(NSInteger)whhxlog;
+ (BOOL)webViewWhhxlog:(NSInteger)whhxlog;
@end
