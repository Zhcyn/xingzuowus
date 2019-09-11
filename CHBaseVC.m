#import "CHBaseVC.h"
#import "CHDefine.h"
#import "UIViewController+NavigationBar.h"
@interface CHBaseVC ()<UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>
@end
@implementation CHBaseVC
- (void)dealloc {
    NSLog(@"%@ dealloc",[self class]);
}
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
    self.view.backgroundColor = UIColorFromRGB(0xfae3e3);
    if (self.navigationController && self.navigationController.viewControllers.firstObject != self) {
        [self loadBackBtn];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark -
#pragma mark - Public method
- (UIButton *)loadBackBtn {
    NSAssert(self.navigationController, @"此界面没有导航栏!");
    UIButton *btn = [self loadItemWithImage:[UIImage imageNamed:@"return"] target:self action:@selector(backClick:) position:CHBarItemPostionLeft];
    return btn;
}
- (UITableView *)addNormalList {
    UITableView *list = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    if ([[UIDevice currentDevice] systemVersion].floatValue >= 11.0) {
        list.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    list.scrollsToTop = YES;
    list.dataSource = self;
    list.delegate = self;
    list.showsHorizontalScrollIndicator = NO;
    list.showsVerticalScrollIndicator = NO;
    list.keyboardDismissMode = UIScrollViewKeyboardDismissModeInteractive;
    list.backgroundColor = [UIColor whiteColor];
    list.separatorColor = UIColorFromRGB(0xeaeaea);
    list.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:list];
    return list;
}
- (UITableView *)addNormalListWithStyle:(UITableViewStyle)style {
    UITableView *list = [[UITableView alloc] initWithFrame:CGRectZero style:style];
    if ([[UIDevice currentDevice] systemVersion].floatValue >= 11.0) {
        list.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    list.scrollsToTop = YES;
    list.dataSource = self;
    list.delegate = self;
    list.showsHorizontalScrollIndicator = NO;
    list.showsVerticalScrollIndicator = NO;
    list.keyboardDismissMode = UIScrollViewKeyboardDismissModeInteractive;
    list.backgroundColor = [UIColor whiteColor];
    list.separatorColor = UIColorFromRGB(0xeaeaea);
    list.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:list];
    return list;
}
- (UIScrollView *)addNormalScrollView {
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
    if ([[UIDevice currentDevice] systemVersion].floatValue >= 11.0) {
        scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    scrollView.scrollsToTop = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.keyboardDismissMode = UIScrollViewKeyboardDismissModeInteractive;
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
    return scrollView;
}
#pragma mark -
#pragma mark - Private method
- (void)backClick:(UIButton *)btn {
    if (self.navigationController.viewControllers.firstObject == self) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
#pragma mark -
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}
#pragma mark -
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.00001f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.00001f;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    return view;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    return view;
}
#pragma mark -
#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
}
@end
