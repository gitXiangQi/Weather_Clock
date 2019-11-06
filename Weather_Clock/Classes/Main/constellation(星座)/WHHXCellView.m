#import "WHHXCellView.h"
@implementation WHHXCellView
- (void)setModel:(WHHXConstellationModel *)model{
    _model = model;
    _nameLabel.text = [NSString stringWithFormat:@"%@ %@",_model.name,_constellationData];
}
- (void)setImage:(UIImage *)image{
    _image = image;
    _imgV.image = image;
}
-  (void)setConstellationData:(NSString *)constellationData{
    _constellationData  = constellationData;
    if (_constellationData.length == 0) {
        _nameLabel.text = @"Loading...";
    }else{
        _nameLabel.text = [NSString stringWithFormat:@"%@ %@",_model.name,_constellationData];
    }
}
@end
