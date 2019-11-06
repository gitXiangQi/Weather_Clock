#import "WHHXConstellationViewController.h"
#import "WHHXGUNMMAFN.h"
#import "MJExtension.h"
#import "WHHXConstellationModel.h"
#import "WHHXiCarousel.h"
#import "WHHXCellView.h"
#import "WHHXPushViewController.h"
#import "AFNetworking.h"
@interface WHHXConstellationViewController ()<iCarouselDataSource,iCarouselDelegate>
{
    NSInteger _assign;
    NSArray *_consPhotoArr;
    NSArray *_consMonthArr;
    NSArray *_consBgImgArr;
    NSMutableArray *requestDataArr;
    NSMutableArray *_dataList;
    WHHXiCarousel *_icarous;
}
@end
@implementation WHHXConstellationViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
    UILabel *line;
    line.backgroundColor = [UIColor clearColor];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], UITextAttributeTextColor, nil]];
    requestDataArr = [NSMutableArray array];
    _dataList = [NSMutableArray arrayWithObjects:@"0",@"1",@"2", nil];
    _consBgImgArr = @[@"WHHX白羊.jpg",@"WHHX金牛.jpg",@"WHHX双子.jpg",@"WHHX巨蟹.jpg",@"WHHX狮子.jpg",@"WHHX处女.jpg",@"WHHX天秤.jpg",@"WHHX天蝎.jpg",@"WHHX射手.jpg",@"WHHX摩羯.jpg",@"WHHX水瓶.jpg",@"WHHX双鱼.jpg"];
    _consPhotoArr = @[@"WHHX白羊a",@"WHHX金牛a",@"WHHX双子a",@"WHHX巨蟹a",@"WHHX狮子a",@"WHHX处女a",@"WHHX天秤a",@"WHHX天蝎a",@"WHHX射手a",@"WHHX摩羯a",@"WHHX水瓶a",@"WHHX双鱼a"];
    [self printStackInfo];
    _consMonthArr = @[@"(3.21~4.19)",@"(4.20~5.20)",@"(5.21~6.21)",@"(6.22~7.22)",@"(7.23~8.22)",@"(8.23~9.22)",@"(9.23~10.23)",@"(10.24~11.22)",@"(11.23~12.21)",@"(12.22~1.19)",@"(1.20~2.18)",@"(2.19~3.20)"];
    [self setTitleColor];
    [self testMomoryLeak];
    [self createCollection];
    [self  judgeTheNet];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}
- (void)judgeTheNet{
    AFNetworkReachabilityManager *reManager = [AFNetworkReachabilityManager sharedManager];
    [reManager startMonitoring];
    [self calculateCycleTime];
    [reManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (status) {
            [self loadData];
        }
        else{
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"无法连接到互联网" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            alert.alertViewStyle = UIAlertViewStyleDefault;
            alert.tag = 11;
            [alert show];
        }
    }];
}
- (void)createCollection{
    _icarous = [[WHHXiCarousel alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH-49-64)];
    _icarous.backgroundColor= kBgColor;
    _icarous.delegate = self;
    _icarous.dataSource = self;
    UILabel *line;
    line.backgroundColor = [UIColor clearColor];
    _icarous.type = iCarouselTypeCoverFlow2;
    _icarous.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_icarous];
}
- (void)setTitleColor{
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"星座" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], UITextAttributeTextColor, nil]];
    NSArray *tempArr = @[@"WHHX白羊.jpg",@"WHHX金牛.jpg",@"WHHX双子.jpg",@"WHHX巨蟹.jpg",@"WHHX狮子.jpg",@"WHHX处女.jpg",@"WHHX天秤.jpg",@"WHHX天蝎.jpg",@"WHHX射手.jpg",@"WHHX摩羯.jpg",@"WHHX水瓶.jpg",@"WHHX双鱼.jpg"];
    UIImageView *backgroundImgV = [[UIImageView alloc]initWithFrame:self.view.bounds];
    backgroundImgV.image = [UIImage imageNamed:@"WHHX星座背景.jpg"];
    [self.view addSubview:backgroundImgV];
}
- (void)loadData{
    NSArray *constellationArr = @[@"白羊座",@"金牛座",@"双子座",@"巨蟹座",@"狮子座",@"处女座",@"天秤座",@"天蝎座",@"射手座",@"摩羯座",@"水瓶座",@"双鱼座"];
    _assign = 0;
    [_dataList removeAllObjects];
    [self calculateHeightWith:constellationArr[0]];
    for (int i = 0; i < constellationArr.count; i++) {
        [_dataList addObject:constellationArr[i]];
    }
    UILabel *line;
    line.backgroundColor = [UIColor clearColor];
    NSString *urlstr = @"http://web.juhe.cn:8080/constellation/getAll";
    NSString *cachesDir = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    for (int i = 0; i < constellationArr.count; i++) {
        NSDictionary *parameters = @{@"key":@"fa942db16d4a353e4d3cd7cc12c64d77",@"consName":constellationArr[i],@"type":@"today"};
        NSString *mycachePath = [cachesDir stringByAppendingPathComponent:[constellationArr objectAtIndex:i]];
        [self printStackInfo];
        @try{
            [WHHXGUNMMAFN xq_getDataWithParameters:parameters withUrl:urlstr withCachePath:mycachePath withBlock:^(id result) {
                WHHXConstellationModel *model = [WHHXConstellationModel mj_objectWithKeyValues:result];
                [requestDataArr addObject:model];
                _assign++;
                if (_assign == 12) {
                    for (int j = 0; j <requestDataArr.count; j++) {
                        WHHXConstellationModel *model2 = requestDataArr[j];
                        for (int k = 0; k < _dataList.count; k++) {
                            NSString *name = _dataList[k];
                            if ([model2.name isEqualToString:name]) {
                                [_dataList replaceObjectAtIndex:k withObject:model2];
                                break;
                            }
                        }
                    }
                    [_icarous reloadData];
                }
                [self calculateCycleTime];
            } withFailedBlock:^(NSError *error) {
                _assign++;
                if (_assign == 12) {
                    for (int j = 0; j <requestDataArr.count; j++) {
                        WHHXConstellationModel *modell = requestDataArr[i];
                        for (int k = 0; k < _dataList.count; k++) {
                            if ([modell.name isEqualToString:_dataList[k]]) {
                                [_dataList replaceObjectAtIndex:k withObject:modell];
                            }
                        }
                    }
                    [self testMomoryLeak];
                    [_icarous reloadData];
                }
            }];
        }
        @catch(NSException *exception){
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:exception.reason delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            alert.alertViewStyle = UIAlertViewStyleDefault;
            alert.tag = 11;
            [alert show];
        }
        @finally{
        }
    }
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}
#pragma mark-----WHHXiCarousel   代理
- (NSInteger)numberOfItemsInCarousel:(WHHXiCarousel *)carousel{
    return _dataList.count;
}
- (UIView *)carousel:(WHHXiCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view{
    NSInteger myindex = 0;
    if (view == nil)
    {
        view = [[[NSBundle mainBundle]loadNibNamed:@"WHHXCellView" owner:nil options:nil]lastObject];
        [self calculateHeightWith:@"天蝎座"];
        view.contentMode = UIViewContentModeCenter;
        view.backgroundColor = [UIColor colorWithRed:.55 green:.55 blue:.55 alpha:.3];
    }
    if (requestDataArr.count > 0) {
        if ([_dataList[index] isKindOfClass:[NSString class]]) {
            ((WHHXCellView *)view).image = [UIImage imageNamed:@"WHHXplaceholder"];
            ((WHHXCellView *)view).constellationData = @"";
        }else{
            ((WHHXCellView *)view).model = _dataList[index];
            ((WHHXCellView *)view).image = [UIImage imageNamed:_consPhotoArr[index]];
            ((WHHXCellView *)view).constellationData = _consMonthArr[index];
        }
        [self calculateCycleTime];
        UILabel *line;
        line.backgroundColor = [UIColor clearColor];
    }
    else{
        ((WHHXCellView *)view).image = [UIImage imageNamed:@"WHHXplaceholder"];
    }
    return view;
}
- (CGSize)calculateHeightWith:(NSString *)content {
    CGRect rect = [content boundingRectWithSize:CGSizeMake(MAXFLOAT, 20) options:0 attributes:nil context:nil];
    return rect.size;
}
- (CGFloat)carousel:(WHHXiCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value
{
    if (option == iCarouselOptionSpacing)
    {
        return value * 1.1;
    }
    return value;
}
- (void)carousel:(WHHXiCarousel *)carousel didSelectItemAtIndex:(NSInteger)index{
    if (_dataList.count == 12) {
        WHHXPushViewController *pushV = [[WHHXPushViewController alloc]init];
        [self calculateHeightWith:@"白羊座"];
        pushV.backgroundImg = [UIImage imageNamed:_consBgImgArr[index]];
        pushV.hidesBottomBarWhenPushed = YES;
        if (![_dataList[index] isKindOfClass:[NSString class]]) {
            pushV.model = _dataList[index];
            [self.navigationController pushViewController:pushV animated:NO];
        }
    }
}
- (void)printStackInfo {
}
- (void)testMomoryLeak {
}
- (void)calculateCycleTime {
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
