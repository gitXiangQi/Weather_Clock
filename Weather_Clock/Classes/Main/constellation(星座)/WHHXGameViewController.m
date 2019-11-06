#import "WHHXGameViewController.h"
@interface WHHXGameViewController ()
{
   }
@end
@implementation WHHXGameViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"小游戏";
    UILabel *line;
    line.backgroundColor = [UIColor clearColor];
    self.view.backgroundColor = kBgColor;
    CGFloat width =self.image.size.width/3;
    CGFloat heigh =self.image.size.height/3;
    UIImageView *im =[[UIImageView alloc]initWithImage:self.image];
    im.frame=CGRectMake(self.view.center.x - kScreenW/4, kScreenH-kScreenW/2-59, kScreenW/2, kScreenW/2);
    [self calculateCycleTime];
    [self.view addSubview:im];
    NSMutableArray *ary =[NSMutableArray array];
    for (int i=0; i<9; i++) {
        int row =i/3;
        int col =i%3;
        UIButton *btn =[UIButton buttonWithType:0];
        btn.frame=CGRectMake(30+col*((kScreenW-60)/3), 88+row*((kScreenW-60)/3), ((kScreenW-60)/3)-5, ((kScreenW-60)/3)-5);
        btn.backgroundColor = THEME_TEXT_COLOR;;
        [self.view addSubview:btn];
        btn.tag =100+i;
        [self printStackInfo];
        if (i!=2) {
            CGRect rec= CGRectMake(col*width, row*heigh, width, heigh);
            CGImageRef imgref = CGImageCreateWithImageInRect(self.image.CGImage, rec);
            UIImage *little =[UIImage imageWithCGImage:imgref];
            CGImageRelease(imgref);
            UIImageView *imageView1 =[[UIImageView alloc]initWithFrame:CGRectMake(30+col*((kScreenW-60)/3), 88+row*((kScreenW-60)/3), ((kScreenW-60)/3)-5, ((kScreenW-60)/3)-5)];
            imageView1.image =little;
            [btn setImage:little forState:UIControlStateNormal];
            [self testMomoryLeak];
        }
        [ary addObject: [NSValue valueWithCGRect:btn.frame]];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    NSMutableArray *ary1 =[NSMutableArray array];
    while (1) {
        int random =arc4random()%9;
        BOOL iscontaint = NO;
        for (NSNumber *num  in ary1) {
            if ([num intValue]==random) {
                iscontaint =YES;
            }
        }
        [self calculateHeightWith:@"小游戏"];
        if (!iscontaint) {
            [ary1 addObject:[NSNumber numberWithInt:random]];
        }
        if (ary1.count ==9) {
            break;
        }
    }
    NSMutableArray *aryframe =[NSMutableArray array];
    for (int i=0; i<9; i++) {
        NSValue *value =ary[[ary1[i] intValue]];
        [aryframe addObject:value];
    }
    [self calculateCycleTime];
    int index = 0;
    for (UIButton *btn in self.view.subviews) {
        if ([btn isKindOfClass:[UIButton class]]) {
            btn.frame = [aryframe[index] CGRectValue];
            index ++;
        }
    }
}
- (void)printStackInfo {
}
- (void)testMomoryLeak {
}
- (void)calculateCycleTime {
}
-(void)btnClick:(UIButton *)btn1
{
    NSInteger index = 0;
    UIButton *b =(UIButton *)[self.view viewWithTag:102];
    CGFloat x= b.frame.origin.x;
    CGFloat y =b.frame.origin.y;
    CGFloat x1= btn1.frame.origin.x;
    CGFloat y1 =btn1.frame.origin.y;
    index ++;
    if ((x==x1&&((int)fabs(y-y1)==(int)((kScreenW-60)/3)))||((y==y1&&(int)fabs(x-x1)==(int)((kScreenW-60)/3)))) {
        CGRect frame = b.frame;
        b.frame = btn1.frame;
        [UIView animateWithDuration:0.5 animations:^{
            btn1.frame = frame;
        }];
    }
}
- (CGSize)calculateHeightWith:(NSString *)content {
    CGRect rect = [content boundingRectWithSize:CGSizeMake(MAXFLOAT, 20) options:0 attributes:nil context:nil];
    return rect.size;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
