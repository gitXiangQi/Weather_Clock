#import "WHHXBirthdayInfoAddedViewController.h"
#import "BirthdayCellModel.h"
#import "WHHXPromptViewController.h"
@interface WHHXBirthdayInfoAddedViewController ()
@property (nonatomic, strong) UILocalNotification *notifi;
@end
@implementation WHHXBirthdayInfoAddedViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    _list = [NSMutableArray<NSMutableArray *> array];
    NSMutableArray *section1 = [@[@"标签"] mutableCopy];
    NSMutableArray *section2 = [@[@"删除"] mutableCopy];
    [_list addObject:section1];
    [_list addObject:section2];
    [self printStackInfo];
    self.view.backgroundColor = UIColor.whiteColor;
    _datePicker = [[UIDatePicker alloc] init];
    [_datePicker setTimeZone:[NSTimeZone defaultTimeZone]];
    [_datePicker setDatePickerMode:UIDatePickerModeDate];
    _datePicker.translatesAutoresizingMaskIntoConstraints = NO;
    NSDate *maxDate = [NSDate dateWithTimeIntervalSinceNow:60 * 60 * 24 * 365];
    NSDate *minDate = [NSDate date];
    UILabel *line;
    line.backgroundColor = [UIColor clearColor];
    _datePicker.maximumDate = maxDate;
    _datePicker.minimumDate = minDate;
    [_datePicker setDate:_tempBirthdayInfo.prompt];
    [_datePicker setBackgroundColor:THEME_COLOR];
    [_datePicker setValue:UIColor.whiteColor forKey:@"textColor"];
    [self.view addSubview:_datePicker];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStyleGrouped];
    _tableView.translatesAutoresizingMaskIntoConstraints = NO;
     _tableView.separatorColor = THEME_CELL_LINE_COLOR;
    [self printStackInfo];
    [_tableView setDelegate:self];
    [_tableView setDataSource:self];
    _tableView.estimatedRowHeight = 44;
    _tableView.rowHeight = UITableViewAutomaticDimension;
     _tableView.backgroundColor = THEME_COLOR;
    NSLayoutConstraint *datePickerTop = [NSLayoutConstraint constraintWithItem:_datePicker
                                                                     attribute:NSLayoutAttributeTop
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.topLayoutGuide
                                                                     attribute:NSLayoutAttributeBottom
                                                                    multiplier:1
                                                                      constant:0];
    UILabel *line1;
    line1.backgroundColor = [UIColor clearColor];
    NSLayoutConstraint *datePickerLeft = [NSLayoutConstraint constraintWithItem:_datePicker
                                                                      attribute:NSLayoutAttributeLeft
                                                                      relatedBy:NSLayoutRelationEqual
                                                                         toItem:self.view
                                                                      attribute:NSLayoutAttributeLeft
                                                                     multiplier:1
                                                                       constant:0];
    NSLayoutConstraint *datePickerRight = [NSLayoutConstraint constraintWithItem:_datePicker
                                                                       attribute:NSLayoutAttributeRight
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:self.view
                                                                       attribute:NSLayoutAttributeRight
                                                                      multiplier:1
                                                                        constant:0];
    NSLayoutConstraint *tableTop = [NSLayoutConstraint constraintWithItem:_tableView
                                                                attribute:NSLayoutAttributeTop
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:_datePicker
                                                                attribute:NSLayoutAttributeBottom
                                                               multiplier:1
                                                                 constant:0];
    UILabel *line2;
    line2.backgroundColor = [UIColor clearColor];
    NSLayoutConstraint *tableBottom = [NSLayoutConstraint constraintWithItem:_tableView
                                                                   attribute:NSLayoutAttributeBottom
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:self.view
                                                                   attribute:NSLayoutAttributeBottom
                                                                  multiplier:1
                                                                    constant:0];
    NSLayoutConstraint *tableLeft = [NSLayoutConstraint constraintWithItem:_tableView
                                                                 attribute:NSLayoutAttributeLeft
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:self.view
                                                                 attribute:NSLayoutAttributeLeft
                                                                multiplier:1
                                                                  constant:0];
    NSLayoutConstraint *tableRight = [NSLayoutConstraint constraintWithItem:_tableView
                                                                  attribute:NSLayoutAttributeRight
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:self.view
                                                                  attribute:NSLayoutAttributeRight
                                                                 multiplier:1
                                                                   constant:0];
    UILabel *line3;
    line3.backgroundColor = [UIColor clearColor];
    [self testMomoryLeak];
    [self.view addSubview:_tableView];
    [self.view addConstraints:@[tableTop, tableBottom, tableLeft, tableRight, datePickerTop, datePickerLeft, datePickerRight]];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存"
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(save)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消"
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:@selector(cancel)];
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"isAdd"]) {
        NSString *flag = [change objectForKey:@"new"];
        if ([flag isEqualToString:@"TRUE"]) {
            self.title = @"添加";
        } else if ([flag isEqualToString:@"FALSE"]) {
            self.title = @"编辑";
        }
    }
}
- (void)removeMyclashRabish {
    [self cancel];
}
- (void)save {
    self.tempBirthdayInfo.prompt = [[_datePicker date] copy];
    if ([self.tempBirthdayInfo.createdTime isEqualToString:@""]) {
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        [df setDateFormat:@"yyyy年MM月dd日 HH时mm分ss秒 zzz"];
        NSString *na = [df stringFromDate:[NSDate date]];
        NSString *curDateString = [na copy];
        self.tempBirthdayInfo.createdTime = [curDateString copy];
    }
    [self calculateCycleTime];
    self.returnPromptToBirthdayListBlock(self.tempBirthdayInfo);
    self.isSavedBlock(@"TRUE");
    [self removeObserver:self forKeyPath:@"isAdd"];
    [self.navigationController popViewControllerAnimated:TRUE];
}
- (void)cancel {
    self.returnPromptToBirthdayListBlock(self.tempBirthdayInfo);
    self.isSavedBlock(@"FALSE");
    [self removeObserver:self forKeyPath:@"isAdd"];
    [self.navigationController popViewControllerAnimated:TRUE];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:true];
    [_tableView deselectRowAtIndexPath:[_tableView indexPathForSelectedRow] animated:TRUE];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _list.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _list[section].count;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        UILabel *line;
        line.backgroundColor = [UIColor clearColor];
        WHHXPromptViewController *b = [[WHHXPromptViewController alloc] init];
        b.prompt = [tableView cellForRowAtIndexPath:indexPath].textLabel.text;
        __weak WHHXBirthdayInfoAddedViewController *weakSelf = self;
        b.returnNewPromptBlock = ^(NSString *newPrompt) {
            [tableView cellForRowAtIndexPath:indexPath].textLabel.text = newPrompt;
            weakSelf.tempBirthdayInfo.remindTime = newPrompt;
        };
        [self.navigationController pushViewController:b animated:YES];
    } else {
        [self testMomoryLeak];
        NSLog(@"section2 called");
        self.returnPromptToBirthdayListBlock(self.tempBirthdayInfo);
        self.isSavedBlock(@"DELETE");
        [self removeObserver:self forKeyPath:@"isAdd"];
        [self.navigationController popViewControllerAnimated:TRUE];
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *const identifer = @"addBirthdayCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (cell == nil) {
        NSLog(@"创建了新的单元格");
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
        cell.backgroundColor = cell.backgroundColor = THEME_CELL_COLOR;
        cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
        cell.selectedBackgroundView.backgroundColor = THEME_CELL_LINE_COLOR;
        UILabel *line;
        line.backgroundColor = [UIColor clearColor];
        if (indexPath.section == 0) {
            cell.imageView.image = [UIImage imageNamed:@"标签"];
            cell.textLabel.text = self.tempBirthdayInfo.remindTime;
            cell.textLabel.textAlignment = NSTextAlignmentRight;
            cell.textLabel.textColor = UIColor.whiteColor;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        } else {
            cell.textLabel.text = _list[indexPath.section][indexPath.row];
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
            cell.textLabel.textColor = UIColor.redColor;
        }
        [self printStackInfo];
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    }
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)printStackInfo {
}
- (void)testMomoryLeak {
}
- (void)calculateCycleTime {
}
@end
