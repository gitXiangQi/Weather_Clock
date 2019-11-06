#import "WHHXBaseNavigationController.h"
@interface WHHXBaseNavigationController ()
@end
@implementation WHHXBaseNavigationController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBar.barTintColor = THEME_COLOR;
    self.navigationBar.tintColor = THEME_TEXT_COLOR;
    self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: UIColor.whiteColor};
}
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}
@end
