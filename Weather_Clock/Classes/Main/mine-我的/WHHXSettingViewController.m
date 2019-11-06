#import "WHHXSettingViewController.h"
#import "WHHXAbouViewController.h"
#import "WHHXWebViewController.h"
@interface WHHXSettingViewController () <UITableViewDelegate , UITableViewDataSource>
@property (nonatomic , strong) NSArray *titleArr;
@property (nonatomic , strong) UITableView *tableView;
@property (nonatomic , strong) UIView *tableHeaderView;
@end
@implementation WHHXSettingViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = nil;
    [self printStackInfo];
    self.navigationItem.title = @"关于";
    [self.view addSubview:self.tableView];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titleArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"myCell"];
        [self calculateCycleTime];
    }
    cell.textLabel.text = [self.titleArr objectAtIndex:indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row == 0) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    else if (indexPath.row == 1) {
        [self testMomoryLeak];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    else if (indexPath.row == 2) {
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.detailTextLabel.text = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        WHHXAbouViewController *vc = [[WHHXAbouViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.row == 1) {
        WHHXWebViewController *vc = [[WHHXWebViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}
- (void)segmentedControlAction:(UISegmentedControl *)segmentedControl {
    NSNumber *segmentOn = [NSNumber numberWithInteger:segmentedControl.selectedSegmentIndex];
    [[NSUserDefaults standardUserDefaults] setObject:segmentOn forKey:@"segmentOn"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (void)switchOn:(UISwitch *)s {
    NSNumber *switchOn = [NSNumber numberWithBool:s.on];
    [[NSUserDefaults standardUserDefaults] setObject:switchOn forKey:@"switchOn"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.scrollEnabled = NO;
        _tableView.tableHeaderView = self.tableHeaderView;
        _tableView.tableFooterView = [UIView new];
        _tableView.separatorColor = kColorFromHex(0xeeeeee);
    }
    return _tableView;
}
- (UIView *)tableHeaderView {
    if (!_tableHeaderView) {
        _tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 200)];
        UIImageView *logo = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
        logo.image = kGetImage(@"AppIcon");
        logo.center = _tableHeaderView.center;
        [_tableHeaderView addSubview:logo];
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_tableHeaderView.frame) - 1, CGRectGetWidth(_tableHeaderView.frame), 1)];
        line.backgroundColor = kColorFromHex(0xeeeeee);
        [_tableHeaderView addSubview:line];
    }
    return _tableHeaderView;
}
- (NSArray *)titleArr {
    if (!_titleArr) {
        _titleArr = @[@"联系我们",@"服务条款",@"当前版本"];
    }
    return _titleArr;
}
@end
