#import "WHHXBaseTabBarController.h"
#import "WHHXBaseNavigationController.h"
#import "WHHXBirthdayTableViewController.h"
#import "WHHXConstellationViewController.h"
#import "WHHXSingleton.h"
#import "WHHXSettingViewController.h"
@interface WHHXBaseTabBarController ()
@end
@implementation WHHXBaseTabBarController
- (void)viewDidLoad {
    [super viewDidLoad];
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        [CYTabBarConfig shared].selectedTextColor = THEME_TEXT_COLOR;
        [CYTabBarConfig shared].textColor = [UIColor whiteColor];
        [CYTabBarConfig shared].HidesBottomBarWhenPushedOption = HidesBottomBarWhenPushedAlone;
        [CYTabBarConfig shared].selectIndex = 0;
        [CYTabBarConfig shared].backgroundColor = THEME_CELL_COLOR;
        self.tabBar.translucent = NO;
        [self addChildViewControllers];
    }
    return self;
}
- (void)addChildViewControllers {
    WHHXBirthdayTableViewController *btvc = [[WHHXBirthdayTableViewController alloc] init];
    btvc.birthdayInfo = [WHHXSingleton.sharedInstance.birthdayInfo mutableCopy];
    WHHXBaseNavigationController *nav = [[WHHXBaseNavigationController alloc] initWithRootViewController:btvc];
    [self addChildController:nav title:@"提醒" imageName:@"tixing" selectedImageName:@"tixing_select"];
    
    [self addChildController:[[WHHXBaseNavigationController alloc] initWithRootViewController:[WHHXConstellationViewController new]] title:@"星座" imageName:@"xinzuo" selectedImageName:@"xinzuo_select"];
    
    [self addChildController:[[WHHXBaseNavigationController alloc] initWithRootViewController:[WHHXSettingViewController new]] title:@"关于" imageName:@"guanyu" selectedImageName:@"guanyu_select"];
}
@end
