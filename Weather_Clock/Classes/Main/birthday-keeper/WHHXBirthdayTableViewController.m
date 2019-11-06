#import "WHHXBirthdayTableViewController.h"
#import "BirthdayCell.h"
#import "BirthdayCellModel.h"
#import "WHHXBirthdayInfoAddedViewController.h"
#import "WHHXSingleton.h"
#import <UserNotifications/UserNotifications.h>
static NSString *const BirthdayCellIdentifier = @"BirthdayCellIdentifier";
static int curBirthdayInfoCount = 0;
@interface WHHXBirthdayTableViewController ()
@property (nonatomic, strong) UIBarButtonItem *edit;
@property (nonatomic, strong) UIBarButtonItem *finished;
@end
@implementation WHHXBirthdayTableViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"提醒";
    [self testMomoryLeak];
    [self addObserver:self forKeyPath:@"birthdayInfo" options:NSKeyValueObservingOptionNew context:nil];
    [self addObserver:self forKeyPath:@"isBirthdayTableEditing" options:NSKeyValueObservingOptionNew context:nil];
    [self addObserver:self forKeyPath:@"isSaved" options:NSKeyValueObservingOptionNew context:nil];
    self.isBirthdayTableEditing = @"FALSE";
    curBirthdayInfoCount = (int)[_birthdayInfo count];
    _tempCellModel = [[BirthdayCellModel alloc] init];
    _curIndex = -1;
    self.edit = [[UIBarButtonItem alloc] initWithTitle:@"编辑"
                                                 style:UIBarButtonItemStylePlain
                                                target:self
                                                action:@selector(editBirthday)];
    self.finished = [[UIBarButtonItem alloc] initWithTitle:@"完成"
                                                     style:UIBarButtonItemStylePlain
                                                    target:self
                                                    action:@selector(finishEditBirthday)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"添加"
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(addBirthday)];
    self.navigationItem.leftBarButtonItem = _edit;
    UIView *myview;
    myview.backgroundColor = [UIColor clearColor];
    if (curBirthdayInfoCount == 0) {
        self.navigationItem.leftBarButtonItem.enabled = FALSE;
    }
    
    _birthdayTableView = [[UITableView alloc] init];
    _birthdayTableView.translatesAutoresizingMaskIntoConstraints = NO;
    _birthdayTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _birthdayTableView.separatorColor = THEME_CELL_LINE_COLOR;
    [self calculateCycleTime];
    _birthdayTableView.tableFooterView = [[UIView alloc] init];
    _birthdayTableView.backgroundColor = THEME_COLOR;
    [self.view addSubview:_birthdayTableView];
    [_birthdayTableView setDelegate:self];
    [_birthdayTableView setDataSource:self];
    _birthdayTableView.estimatedRowHeight = 88;
    _birthdayTableView.rowHeight = UITableViewAutomaticDimension;
    self.birthdayTableView.editing = FALSE;
    
    NSLayoutConstraint *birthdayTableViewLeft = [NSLayoutConstraint constraintWithItem:_birthdayTableView
                                                                             attribute:NSLayoutAttributeLeft
                                                                             relatedBy:NSLayoutRelationEqual
                                                                                toItem:self.view
                                                                             attribute:NSLayoutAttributeLeft
                                                                            multiplier:1
                                                                              constant:0];
    [self testMomoryLeak];
    NSLayoutConstraint *birthdayTableViewRight = [NSLayoutConstraint constraintWithItem:_birthdayTableView
                                                                              attribute:NSLayoutAttributeRight
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:self.view
                                                                              attribute:NSLayoutAttributeRight
                                                                             multiplier:1
                                                                               constant:0];
    NSLayoutConstraint *birthdayTableViewTop = [NSLayoutConstraint constraintWithItem:_birthdayTableView
                                                                            attribute:NSLayoutAttributeTop
                                                                            relatedBy:NSLayoutRelationEqual
                                                                               toItem:self.view
                                                                            attribute:NSLayoutAttributeTop
                                                                           multiplier:1
                                                                             constant:0];
    [self printStackInfo];
    NSLayoutConstraint *birthdayTableViewBottom = [NSLayoutConstraint constraintWithItem:_birthdayTableView
                                                                               attribute:NSLayoutAttributeBottom
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:self.view
                                                                               attribute:NSLayoutAttributeBottom
                                                                              multiplier:1
                                                                                constant:0];
    [self.view addConstraints:@[birthdayTableViewLeft, birthdayTableViewRight, birthdayTableViewTop, birthdayTableViewBottom]];
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"isSaved"]) {
        NSString *flag = [change objectForKey:@"new"];
        UIView *view;
        view.backgroundColor = [UIColor clearColor];
        if ([flag isEqualToString:@"TRUE"] && self.curIndex == -1) {
            curBirthdayInfoCount++;
            [[self mutableArrayValueForKeyPath:@"birthdayInfo"] insertObject:[_tempCellModel copy] atIndex:0];
            [self.birthdayTableView reloadData];
        } else if ([flag isEqualToString:@"TRUE"] && self.curIndex != -1) {
            [[self mutableArrayValueForKeyPath:@"birthdayInfo"] replaceObjectAtIndex:_curIndex withObject:[_tempCellModel copy]];
            [self.birthdayTableView reloadData];
            [self updateLocalNotification:_birthdayInfo[_curIndex]];
        } else if ([flag isEqualToString:@"FALSE"]) {
            [self.birthdayTableView reloadData];
        } else if ([flag isEqualToString:@"DELETE"] && _curIndex != -1) {
            if (self.birthdayInfo[_curIndex].on) {
                [self cancelLocalNotifications:_birthdayInfo[_curIndex]];
            }
            curBirthdayInfoCount--;
            [[self mutableArrayValueForKeyPath:@"birthdayInfo"] removeObjectAtIndex:_curIndex];
            [self.birthdayTableView reloadData];
        }
        WHHXSingleton.sharedInstance.birthdayInfo = _birthdayInfo;
    }
    if ([keyPath isEqualToString:@"birthdayInfo"]) {
        if (curBirthdayInfoCount > 0) {
            self.navigationItem.leftBarButtonItem.enabled = TRUE;
        } else {
            self.navigationItem.leftBarButtonItem = _edit;
            self.navigationItem.leftBarButtonItem.enabled = FALSE;
            self.birthdayTableView.editing = FALSE;
            self.isBirthdayTableEditing = @"FALSE";
            self.navigationItem.rightBarButtonItem.enabled = TRUE;
        }
    }
    if ([keyPath isEqualToString:@"isBirthdayTableEditing"]) {
        NSString *editFlag = [change objectForKey:@"new"];
        if ([editFlag isEqualToString:@"TRUE"]) {
            self.navigationItem.rightBarButtonItem.enabled = FALSE;
        } else {
            self.navigationItem.rightBarButtonItem.enabled = TRUE;
        }
    }
}
- (void)addBirthday {
    WHHXBirthdayInfoAddedViewController *b = [[WHHXBirthdayInfoAddedViewController alloc] init];
    [b addObserver:b forKeyPath:@"isAdd" options:NSKeyValueObservingOptionNew context:nil];
    self.curIndex = -1;
    [self.tempCellModel clear];
    b.tempBirthdayInfo = [self.tempCellModel copy];
    b.isAdd = @"TRUE";
    UIView *view;
    view.backgroundColor = [UIColor clearColor];
    __weak WHHXBirthdayTableViewController *weakSelf = self;
    b.isSavedBlock = ^(NSString *isSaved) {
        weakSelf.isSaved = isSaved;
    };
    b.returnPromptToBirthdayListBlock = ^(BirthdayCellModel *bcm) {
        weakSelf.tempCellModel = [bcm copy];
    };
    [self.navigationController pushViewController:b animated:YES];
}
- (void)editBirthday {
    [_birthdayTableView setEditing:TRUE animated:TRUE];
    self.isBirthdayTableEditing = @"TRUE";
    UIView *view;
    view.backgroundColor = [UIColor clearColor];
    self.navigationItem.leftBarButtonItem = _finished;
}
- (void)finishEditBirthday {
    [_birthdayTableView setEditing:FALSE animated:TRUE];
    self.isBirthdayTableEditing = @"FALSE";
    self.navigationItem.leftBarButtonItem = _edit;
    [self testMomoryLeak];
}
- (void)dealloc {
    [self removeObserver:self forKeyPath:@"isSaved"];
    [self removeObserver:self forKeyPath:@"birthdayInfo"];
    [self removeObserver:self forKeyPath:@"isBirthdayTableEditing"];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _birthdayInfo.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BirthdayCell *item = [BirthdayCell initWithTableView:tableView andReuseIdentifier:BirthdayCellIdentifier];
    NSDate *date = _birthdayInfo[indexPath.row].prompt;
    item.date = date;
    NSTimeInterval sec = [date timeIntervalSinceNow];
    NSDate *currentDate = [[NSDate alloc] initWithTimeIntervalSinceNow:sec];
    [self testMomoryLeak];
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"MM月dd日"];
    NSString *na = [df stringFromDate:currentDate];
    [item.prompt setText:na];
    [item.createdTime setText:_birthdayInfo[indexPath.row].createdTime];
    [item.remindTime setText:_birthdayInfo[indexPath.row].remindTime];
    [item.on addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
    if (_birthdayInfo[indexPath.row].isOn) {
        [item.on setOn:TRUE];
        item.isSwitchOn = @"TRUE";
    } else {
        [item.on setOn:FALSE];
        item.isSwitchOn = @"FALSE";
    }
    return item;
}
- (void)switchChanged:(id)sender {
    BirthdayCell *curCell = (BirthdayCell *)[[sender superview] superview];
    NSIndexPath *curIndexPath = [_birthdayTableView indexPathForCell:curCell];
    [self calculateCycleTime];
    if ([curCell.isSwitchOn isEqualToString:@"TRUE"]) {
        curCell.isSwitchOn = @"FALSE";
        self.birthdayInfo[curIndexPath.row].on = FALSE;
        WHHXSingleton.sharedInstance.birthdayInfo = _birthdayInfo;
        [self cancelLocalNotifications:self.birthdayInfo[curIndexPath.row]];
    } else {
        curCell.isSwitchOn = @"TRUE";
        self.birthdayInfo[curIndexPath.row].on = TRUE;
        WHHXSingleton.sharedInstance.birthdayInfo = _birthdayInfo;
        [self addLocalNotifications:self.birthdayInfo[curIndexPath.row]];
    }
}
- (NSDate *)calcuFireDate:(NSDate *)remindDate {
    NSCalendar *calender = [NSCalendar autoupdatingCurrentCalendar];
    unsigned unitFlags = NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *dateComponents = [[calender components:unitFlags fromDate:remindDate] copy];
    [self calculateCycleTime];
    NSDate *mdDate = [[calender dateFromComponents:dateComponents] copy];
    NSDate *now = [NSDate dateWithTimeIntervalSinceNow:0];
    dateComponents = [[calender components:unitFlags fromDate:now] copy];
    NSDate *curDate = [[calender dateFromComponents:dateComponents] copy];
    NSTimeInterval ti = [curDate timeIntervalSinceDate:mdDate];
    NSDate *fireDate = [NSDate dateWithTimeIntervalSinceNow:-ti + 20];
    return fireDate;
}
- (void)addLocalNotifications:(BirthdayCellModel *)bcm {
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    localNotification.timeZone = [NSTimeZone defaultTimeZone];
    localNotification.fireDate = [self calcuFireDate:bcm.prompt];
    [self calculateCycleTime];
    localNotification.alertBody = bcm.remindTime;
    localNotification.soundName = UILocalNotificationDefaultSoundName;
    localNotification.repeatInterval = kCFCalendarUnitYear;
    localNotification.applicationIconBadgeNumber = 1;
    [self printStackInfo];
    localNotification.userInfo = @{@"createdTime" : bcm.createdTime};
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
}
- (void)cancelLocalNotifications:(BirthdayCellModel *)bcm {
    NSArray *notifications = [UIApplication sharedApplication].scheduledLocalNotifications;
    NSString *notificationId = bcm.createdTime;
    [self printStackInfo];
    for (UILocalNotification *localNotification in notifications) {
        if ([[localNotification.userInfo objectForKey:@"createdTime"] isEqualToString:notificationId]) {
            [[UIApplication sharedApplication] cancelLocalNotification:localNotification];
        }
    }
}
- (void)updateLocalNotification:(BirthdayCellModel *)bcm {
    [self cancelLocalNotifications:bcm];
    [self addLocalNotifications:bcm];
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray<NSIndexPath *> *d = @[indexPath];
    [self printStackInfo];
    BirthdayCell *c = [self.birthdayTableView cellForRowAtIndexPath:indexPath];
    if ([c.isSwitchOn isEqualToString:@"TRUE"]) {
        [self cancelLocalNotifications:_birthdayInfo[indexPath.row]];
    }
    curBirthdayInfoCount--;
    [self printStackInfo];
    [[self mutableArrayValueForKeyPath:@"birthdayInfo"] removeObjectAtIndex:indexPath.row];
    WHHXSingleton.sharedInstance.birthdayInfo = _birthdayInfo;
    [self.birthdayTableView deleteRowsAtIndexPaths:d withRowAnimation:UITableViewRowAnimationLeft];
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}
- (void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath {
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    WHHXBirthdayInfoAddedViewController *b = [[WHHXBirthdayInfoAddedViewController alloc] init];
    self.curIndex = indexPath.row;
    self.tempCellModel = [_birthdayInfo[_curIndex] copy];
    b.tempBirthdayInfo = self.tempCellModel;
    [b addObserver:b forKeyPath:@"isAdd" options:NSKeyValueObservingOptionNew context:nil];
    b.isAdd = @"FALSE";
    [self printStackInfo];
    __weak WHHXBirthdayTableViewController *weakSelf = self;
    b.returnPromptToBirthdayListBlock = ^(BirthdayCellModel *model) {
        weakSelf.tempCellModel = [model copy];
    };
    b.isSavedBlock = ^(NSString *isSaved) {
        weakSelf.isSaved = [isSaved copy];
    };
    [self.navigationController pushViewController:b animated:TRUE];
}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
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
