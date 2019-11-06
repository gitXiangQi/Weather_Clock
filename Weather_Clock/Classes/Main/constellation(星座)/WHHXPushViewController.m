#import "WHHXPushViewController.h"
#import "WHHXGameViewController.h"
@interface WHHXPushViewController ()
@end
@implementation WHHXPushViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"星座";
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self calculateCycleTime];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], UITextAttributeTextColor, nil]];
    UIImageView *imgV = [[UIImageView alloc]initWithFrame:self.view.bounds];
    imgV.image = self.backgroundImg;
    imgV.contentMode = UIViewContentModeScaleAspectFill;
    [self.view insertSubview:imgV atIndex:0];
    [self calculateHeightWith:self.constellationName.text];
    _work.text = _model.work;
    _summary.text = _model.summary;
    _data.text = _model.datetime;
    _love.text = _model.love;
    _color.text = _model.color;
    _summary.shadowColor = [UIColor blackColor];
    _health.text = _model.health;
    _constellationName.text = _model.name;
    _QFriend.text = _model.QFriend;
    _summary.shadowOffset = CGSizeMake(.3, .3);
    _money.text = _model.money;
    _number.text = [NSString stringWithFormat:@"%@",_model.number];
    _all.text = _model.all;
    [self createNavigationItem];
    UIView *maskView = [[UIView alloc]initWithFrame:self.view.bounds];
    maskView.backgroundColor = [UIColor blackColor];
    maskView.alpha = .2;
    [self testMomoryLeak];
    [self.view insertSubview:maskView aboveSubview:imgV];
}
- (CGSize)calculateHeightWith:(NSString *)content {
    CGRect rect = [content boundingRectWithSize:CGSizeMake(MAXFLOAT, 20) options:0 attributes:nil context:nil];
    return rect.size;
}
-(void)createNavigationItem{
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 88, 44)];
    [btn setTitle:@"小游戏" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    UILabel *line;
    line.backgroundColor = [UIColor clearColor];
    [btn addTarget:self action:@selector(btnAct:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = item;
}
-(void)btnAct:(UIButton *)btn{
    WHHXGameViewController *game = [[WHHXGameViewController alloc]init];
    game.image = self.backgroundImg;
    [self.navigationController pushViewController:game animated:YES];
}
- (void)printStackInfo {
}
- (void)testMomoryLeak {
}
- (void)calculateCycleTime {
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
