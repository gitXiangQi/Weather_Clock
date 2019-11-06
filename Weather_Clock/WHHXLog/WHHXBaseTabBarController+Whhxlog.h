#import "CYTabBarController.h"
#import "WHHXBaseTabBarController.h"
#import "WHHXBaseNavigationController.h"
#import "WHHXBirthdayTableViewController.h"
#import "WHHXConstellationViewController.h"
#import "WHHXSingleton.h"
#import "WHHXSettingViewController.h"
@interface WHHXBaseTabBarController (Whhxlog)
+ (BOOL)viewDidLoadWhhxlog:(NSInteger)whhxlog;
+ (BOOL)initWhhxlog:(NSInteger)whhxlog;
+ (BOOL)addChildViewControllersWhhxlog:(NSInteger)whhxlog;
+ (BOOL)prepareForSegueSenderWhhxlog:(NSInteger)whhxlog;
@end
