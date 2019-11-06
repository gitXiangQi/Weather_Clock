#import <UIKit/UIKit.h>
#import "BirthdayCellModel.h"
@interface WHHXBirthdayTableViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *birthdayTableView;
@property (nonatomic, strong) NSMutableArray<BirthdayCellModel *> *birthdayInfo;
@property (nonatomic, copy) NSString *isBirthdayTableEditing;
@property (nonatomic, copy)  NSString *isSaved;
@property (nonatomic, assign) NSInteger curIndex;
@property (nonatomic, strong)  BirthdayCellModel *tempCellModel;
@end
