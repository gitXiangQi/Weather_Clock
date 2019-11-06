#import <UIKit/UIKit.h>
@interface WHHXPromptEditCell : UITableViewCell
@property (nonatomic, strong) UITextField *promptEditField;
+ (instancetype)initWith:(UITableView *)tableView andReuseIdentifier:(NSString *)identifier;
@end
