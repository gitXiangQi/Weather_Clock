#import <UIKit/UIKit.h>
@class BirthdayCellModel;
typedef void(^returnPromptToBirthdayList)(BirthdayCellModel *);
typedef void(^isSaved)(NSString *);
@interface WHHXBirthdayInfoAddedViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) BirthdayCellModel *tempBirthdayInfo;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, copy) returnPromptToBirthdayList returnPromptToBirthdayListBlock;
@property (nonatomic, copy) isSaved isSavedBlock;
@property (nonatomic, copy) NSString *isAdd;
@property (nonatomic, strong) NSMutableArray<NSMutableArray *> *list;
@end
