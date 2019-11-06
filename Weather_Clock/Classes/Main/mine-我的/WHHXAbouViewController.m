#import "WHHXAbouViewController.h"
#import "Masonry.h"
@interface WHHXAbouViewController ()
@property (nonatomic , strong) UITextView *tv;
@end
@implementation WHHXAbouViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"联系我们";
    [self testMomoryLeak];
    [self.view addSubview:self.tv];
    [self.tv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    self.tv.text = @"邮件反馈：307410951@qq.com\nQQ反馈：307410951";
}
- (UITextView *)tv {
    if (!_tv) {
        _tv= [[UITextView alloc] init];
        _tv.editable = NO;
        _tv.alwaysBounceVertical = YES;
        _tv.contentInset = UIEdgeInsetsMake(0, 5, 0, 5);
        _tv.textColor = kColorFromHex(0x333333);
        _tv.font = kPingFangFont(16);
    }
    return _tv;
}
@end
