#import <UIKit/UIKit.h>
#import "WHHXConstellationModel.h"
@interface WHHXCellView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *imgV;
@property(nonatomic,retain)UIImage *image;
@property(nonatomic,retain)WHHXConstellationModel *model;
@property (nonatomic , strong) NSString *name;
@property(nonatomic,copy)NSString *constellationData;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@end
