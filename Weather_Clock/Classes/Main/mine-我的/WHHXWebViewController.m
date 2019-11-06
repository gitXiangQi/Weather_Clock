#import "WHHXWebViewController.h"
#import "Masonry.h"
#import "WHToast.h"
@interface WHHXWebViewController ()<UIWebViewDelegate>
@property (nonatomic , strong) UIWebView *webView;
@end
@implementation WHHXWebViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"隐私条款";
    [self.view addSubview:self.webView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    self.webView.delegate = self;
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:URL_H5_TERMS]]];
    [WHToast showMessage:@"加载中请稍候..." duration:1 finishHandler:^{
        [WHToast hide];
    }];
}
- (void)webViewDidStartLoad:(UIWebView *)webView {
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [WHToast showSuccessWithMessage:@"加载完成" duration:1 finishHandler:^{
        [WHToast hide];
    }];
}
- (UIWebView *)webView {
    if (!_webView) {
        _webView = [[UIWebView alloc]init];
    }
    return _webView;
}
@end
