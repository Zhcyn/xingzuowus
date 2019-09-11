#import "websViewController.h"
#import "NSString+EX.h"
#define iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
#define HD_Default_Portrait_Status_Height (iPhoneX ? 44.f : 20.f)
#define HD_Default_Portrait_NAVIGATION_BAR_HEIGHT (iPhoneX ? 88.f : 64.f)
#define HD_Default_Portrait_TAB_BAR_HEIGHT (iPhoneX ? (49.f+34.f) : 49.f)
@interface websViewController ()
@property (strong, nonatomic) UIWebView *webView;
@end
@implementation websViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
    [self initTabbar];
}
- (void)createUI {
    CGSize size = [UIScreen mainScreen].bounds.size;
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, HD_Default_Portrait_Status_Height, size.width, size.height - HD_Default_Portrait_TAB_BAR_HEIGHT-HD_Default_Portrait_Status_Height)];
    NSURL *url = [NSURL URLWithString:self.urlString];
    NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:url];
    [self.webView loadRequest:urlRequest];
    [self.view addSubview:self.webView];
}
- (void)initTabbar {
    CGSize size = [UIScreen mainScreen].bounds.size;
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, size.height - HD_Default_Portrait_TAB_BAR_HEIGHT, size.width, HD_Default_Portrait_TAB_BAR_HEIGHT)];
    [bgView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:bgView];
    NSArray *array = [NSArray arrayWithObjects:@"首页",@"后退",@"前进",@"刷新", nil];
    float btnWidth = size.width/4.0;
    for (int i = 1; i<5; i++) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake((i-1)*btnWidth, 4, btnWidth, 34)];
        [button setTag:i];
        NSString *title =[array objectAtIndex:i-1];
        CGSize fontSize = [title sizeWithMaxW:btnWidth font:[UIFont systemFontOfSize:10]];
        [button setTitle:title forState:UIControlStateNormal];
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        [button.titleLabel setFont:[UIFont systemFontOfSize:10]];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleEdgeInsets:UIEdgeInsetsMake(19, -fontSize.width, -19, fontSize.width)];
        [button setImage:[UIImage imageNamed:[array objectAtIndex:i-1]] forState:UIControlStateNormal];
        [bgView addSubview:button];
        [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    }
}
- (void)clickButton:(UIButton *)button {
    NSLog(@"button");
    switch (button.tag) {
        case 1:{
            NSURL *url = [NSURL URLWithString:self.urlString];
            NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:url];
            [self.webView loadRequest:urlRequest];
        }
            break;
        case 2:{
            [self.webView goBack];
        }
            break;
        case 3:{
            [self.webView goForward];
        }
            break;
        case 4:{
            [self.webView reload];
        }
            break;
        default:
            break;
    }
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSString* reqUrl = request.URL.absoluteString;
    if ([reqUrl hasPrefix:@"alipays://"] || [reqUrl hasPrefix:@"alipay://"]) {
        BOOL bSucc = [[UIApplication sharedApplication]openURL:request.URL];
    }
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
