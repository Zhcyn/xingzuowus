#import "CHHomeVC.h"
#import "CHDefine.h"
#import "Masonry.h"
#import "CHSearchVC.h"
#import "CHFortuneVC.h"
#import "CHPairVC.h"
#import "CHAstrolabeVC.h"
#import "CHZodiacVC.h"
@interface CHHomeVC ()
@property (nonatomic, strong) UIImageView *bgImgView;
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) NSMutableDictionary *dataDic;
@end
@implementation CHHomeVC
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self setupUI];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark - Lazy load
- (UIImageView *)bgImgView {
    if (nil == _bgImgView) {
        _bgImgView = [[UIImageView alloc] init];
        _bgImgView.image = [UIImage imageNamed:@"bgImg"];
        _bgImgView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _bgImgView;
}
- (UIView *)bgView {
    if (nil == _bgView) {
        _bgView = [[UIView alloc] init];
    }
    return _bgView;
}
- (NSMutableDictionary *)dataDic {
    if (nil == _dataDic) {
        _dataDic = [NSMutableDictionary dictionary];
    }
    return _dataDic;
}
#pragma mark - Private method
- (void)initData {
    self.dataDic[@"icon"] = @[@"search", @"fortune", @"pair"];
    self.dataDic[@"title"] = @[@"星座查询", @"星座运势", @"星座配对"];
}
- (void)setupUI {
    self.title = @"星座屋";
    [self.view addSubview:self.bgView];
    self.bgView.backgroundColor = UIColorFromRGB(0xffffff);
    self.bgView.layer.cornerRadius = 20.f;
    self.bgView.layer.masksToBounds = YES;
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(20, 20, 20, 20));
    }];
    [self.bgView addSubview:self.bgImgView];
    [self.bgImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.bgView);
    }];
    UIImageView *imgView0;
    NSArray *arr = self.dataDic[@"icon"];
    for (int i = 0; i < arr.count; i++) {
        UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:arr[i]]];
        imgView.tag = i;
        imgView.layer.cornerRadius = 50;
        imgView.layer.masksToBounds = YES;
        imgView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
        [imgView addGestureRecognizer:tap];
        [self.bgView addSubview:imgView];
        [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            if (i % 2 == 0) {
                make.right.equalTo(self.bgView.mas_centerX).offset(-15);
            }else {
                make.left.equalTo(self.bgView.mas_centerX).offset(15);
            }
            if (imgView0) {
                make.top.equalTo(imgView0.mas_bottom).offset(40);
            }else {
                make.top.equalTo(self.bgView).offset(70);
            }
            make.width.height.mas_equalTo(100);
        }];
        imgView0 = imgView;
    }
}
- (void)handleTap:(UITapGestureRecognizer *)tapGes {
    NSLog(@"clicked index:%ld ", (long)tapGes.view.tag);
    switch (tapGes.view.tag) {
        case 0:{
            CHSearchVC *vc = [[CHSearchVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1:{
            CHFortuneVC *vc = [[CHFortuneVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 2:{
            CHPairVC *vc = [[CHPairVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 3:{
            CHAstrolabeVC *vc = [[CHAstrolabeVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 4:{
            CHZodiacVC *vc = [[CHZodiacVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        default:
            break;
    }
}
@end
