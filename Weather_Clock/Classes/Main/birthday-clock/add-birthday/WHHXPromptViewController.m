#import "WHHXPromptViewController.h"
#import "WHHXPromptEditCell.h"
static NSString *const promtpIdentifier = @"PromptEditCellIdentifier";
@interface WHHXPromptViewController ()
@end
@implementation WHHXPromptViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"确定"
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(sure)];
    [self calculateHeightWith:self.prompt];
    self.title = @"标签";
    self.view.backgroundColor = UIColor.whiteColor;
    _promptTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStyleGrouped];
    [_promptTable setDelegate:self];
    [_promptTable setDataSource:self];
    _promptTable.separatorColor = THEME_CELL_LINE_COLOR;
    _promptTable.rowHeight = 44;
    UILabel *line1;
    line1.backgroundColor = [UIColor clearColor];
    _promptTable.translatesAutoresizingMaskIntoConstraints = NO;
    _promptTable.backgroundColor = THEME_COLOR;
    [self.view addSubview:_promptTable];
    NSLayoutConstraint *promptTableTop = [NSLayoutConstraint constraintWithItem:_promptTable
                                                                      attribute:NSLayoutAttributeTop
                                                                      relatedBy:NSLayoutRelationEqual
                                                                         toItem:self.view
                                                                      attribute:NSLayoutAttributeTop
                                                                     multiplier:1
                                                                       constant:0];
    NSLayoutConstraint *promptTableBottom = [NSLayoutConstraint constraintWithItem:_promptTable
                                                                         attribute:NSLayoutAttributeBottom
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:self.view
                                                                         attribute:NSLayoutAttributeBottom
                                                                        multiplier:1
                                                                          constant:0];
    UILabel *line2;
    line2.backgroundColor = [UIColor clearColor];
    NSLayoutConstraint *promptTableLeft = [NSLayoutConstraint constraintWithItem:_promptTable
                                                                       attribute:NSLayoutAttributeLeft
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:self.view
                                                                       attribute:NSLayoutAttributeLeft
                                                                      multiplier:1
                                                                        constant:0];
    NSLayoutConstraint *promptTableRight = [NSLayoutConstraint constraintWithItem:_promptTable
                                                                        attribute:NSLayoutAttributeRight
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:self.view
                                                                        attribute:NSLayoutAttributeRight
                                                                       multiplier:1
                                                                         constant:0];
    [self.view addConstraints:@[promptTableTop, promptTableBottom, promptTableLeft, promptTableRight]];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:true];
    NSLog(@"view will appear");
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WHHXPromptEditCell *cell = [WHHXPromptEditCell initWith:tableView andReuseIdentifier:promtpIdentifier];
    [cell.promptEditField setDelegate:self];
    cell.promptEditField.returnKeyType = UIReturnKeyDone;
    cell.promptEditField.keyboardAppearance = UIKeyboardAppearanceDark;
    cell.promptEditField.textColor = UIColor.whiteColor;
    [self calculateHeightWith:cell.promptEditField.text];
    [cell.promptEditField setTintColor:THEME_TEXT_COLOR];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    cell.promptEditField.text = _prompt;
    return cell;
}
- (void)sure
{
    [self.view endEditing:YES];
    WHHXPromptEditCell *cell = (WHHXPromptEditCell *)[self.promptTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    self.prompt = cell.promptEditField.text;
    UILabel *line1;
    line1.backgroundColor = [UIColor clearColor];
    self.returnNewPromptBlock(self.prompt);
    [self.navigationController popViewControllerAnimated:TRUE];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    self.prompt = textField.text;
    UILabel *line2;
    line2.backgroundColor = [UIColor clearColor];
    self.returnNewPromptBlock(self.prompt);
    [self.navigationController popViewControllerAnimated:TRUE];
    return TRUE;
}
- (void)printStackInfo {
}
- (void)testMomoryLeak {
}
- (void)calculateCycleTime {
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"请输入新的标签";
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (CGSize)calculateHeightWith:(NSString *)content {
    CGRect rect = [content boundingRectWithSize:CGSizeMake(MAXFLOAT, 20) options:0 attributes:nil context:nil];
    return rect.size;
}
@end
