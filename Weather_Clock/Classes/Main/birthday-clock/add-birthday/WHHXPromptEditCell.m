#import "WHHXPromptEditCell.h"
@implementation WHHXPromptEditCell
+ (instancetype)initWith:(UITableView *)tableView andReuseIdentifier:(NSString *)identifier {
    WHHXPromptEditCell *pCell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (pCell) return pCell;
    pCell = [[WHHXPromptEditCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    pCell.promptEditField = [[UITextField alloc] init];
    pCell.promptEditField.translatesAutoresizingMaskIntoConstraints = NO;
    [pCell.contentView addSubview:pCell.promptEditField];
    pCell.backgroundColor = THEME_CELL_COLOR;
    NSLayoutConstraint *promptEditFieldCenterY = [NSLayoutConstraint constraintWithItem:pCell.promptEditField
                                                                              attribute:NSLayoutAttributeCenterY
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:pCell.contentView
                                                                              attribute:NSLayoutAttributeCenterY
                                                                             multiplier:1
                                                                               constant:0];
    NSLayoutConstraint *promptEditFieldLeft = [NSLayoutConstraint constraintWithItem:pCell.promptEditField
                                                                           attribute:NSLayoutAttributeLeft
                                                                           relatedBy:NSLayoutRelationEqual
                                                                              toItem:pCell.contentView
                                                                           attribute:NSLayoutAttributeLeft
                                                                          multiplier:1
                                                                            constant:12];
    NSLayoutConstraint *promptEditFieldRight = [NSLayoutConstraint constraintWithItem:pCell.promptEditField
                                                                            attribute:NSLayoutAttributeRight
                                                                            relatedBy:NSLayoutRelationEqual
                                                                               toItem:pCell.contentView
                                                                            attribute:NSLayoutAttributeRight
                                                                           multiplier:1
                                                                             constant:-12];
    [pCell.contentView addConstraints:@[promptEditFieldCenterY, promptEditFieldLeft, promptEditFieldRight]];
    [pCell.promptEditField setClearButtonMode:UITextFieldViewModeWhileEditing];
    return pCell;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
@end
