#import <UIKit/UIKit.h>
#import "WHHXConstellationModel.h"
@interface WHHXPushViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *constellationName;
@property (weak, nonatomic) IBOutlet UILabel *data;
@property (weak, nonatomic) IBOutlet UILabel *summary;
@property (weak, nonatomic) IBOutlet UILabel *health;
@property (weak, nonatomic) IBOutlet UILabel *QFriend;
@property (weak, nonatomic) IBOutlet UILabel *money;
@property (weak, nonatomic) IBOutlet UILabel *number;
@property (weak, nonatomic) IBOutlet UILabel *work;
@property (weak, nonatomic) IBOutlet UILabel *all;
@property (weak, nonatomic) IBOutlet UILabel *color;
@property (weak, nonatomic) IBOutlet UILabel *love;
@property(nonatomic,retain)WHHXConstellationModel *model;
@property (nonatomic,retain)UIImage *backgroundImg;
@end
