#import "CHPairDetailVC.h"
#import "Masonry.h"
#import "CHDefine.h"
#import "CHPairModel.h"
#import "CHFortuneModel.h"
#import "ConstellationModel.h"
#import "NSAttributedString+EX.h"
@interface CHPairDetailVC ()
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIImageView *leftImgView;
@property (nonatomic, strong) UIImageView *rightImgView;
@property (nonatomic, strong) UILabel *leftTitleLabel;
@property (nonatomic, strong) UILabel *rightTitleLabel;
@property (nonatomic, strong) UILabel *descLabel;
@property (nonatomic, strong) CHPairModel *pModel;
@property (nonatomic, strong) NSMutableArray *dataArray;
@end
@implementation CHPairDetailVC
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"星座配对详情";
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Pair" ofType:@"plist"];
    NSArray *arr = [NSArray arrayWithContentsOfFile:filePath];
    for (NSDictionary *dic in arr) {
        if ([dic[@"male"] isEqualToString:self.leftModel.name] && [dic[@"female"] isEqualToString:self.rightModel.name]) {
            self.pModel = [[CHPairModel alloc] initWithDic:dic];
        }
    }
    [self setupUI];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark - Lazy load
- (UIView *)contentView {
    if (nil == _contentView) {
        _contentView = [[UIView alloc] init];
    }
    return _contentView;
}
- (UIView *)bgView {
    if (nil == _bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = UIColorFromRGB(0xfd94b4);
        _bgView.layer.cornerRadius = 10.f;
        _bgView.layer.masksToBounds = YES;
    }
    return _bgView;
}
- (UIImageView *)leftImgView {
    if (nil == _leftImgView) {
        _leftImgView = [[UIImageView alloc] init];
        _leftImgView.layer.masksToBounds = YES;
        _leftImgView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _leftImgView;
}
- (UIImageView *)rightImgView {
    if (nil == _rightImgView) {
        _rightImgView = [[UIImageView alloc] init];
        _rightImgView.layer.masksToBounds = YES;
        _rightImgView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _rightImgView;
}
- (UILabel *)leftTitleLabel {
    if (nil == _leftTitleLabel) {
        _leftTitleLabel = [[UILabel alloc] init];
        _leftTitleLabel.textColor = UIColorFromRGB(0xf12b6b);
        _leftTitleLabel.font = [UIFont systemFontOfSize:14];
        _leftTitleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _leftTitleLabel;
}
- (UILabel *)rightTitleLabel {
    if (nil == _rightTitleLabel) {
        _rightTitleLabel = [[UILabel alloc] init];
        _rightTitleLabel.textColor = UIColorFromRGB(0xf12b6b);
        _rightTitleLabel.font = [UIFont systemFontOfSize:14];
        _rightTitleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _rightTitleLabel;
}
- (UILabel *)descLabel {
    if (nil == _descLabel) {
        _descLabel = [[UILabel alloc] init];
        _descLabel.textColor = [UIColor whiteColor];
        _descLabel.font = [UIFont boldSystemFontOfSize:20];
        _descLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _descLabel;
}
- (NSMutableArray *)dataArray {
    if (nil == _dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
#pragma mark - Private method
- (void)setupUI {
    self.scrollView = [self addNormalScrollView];
    self.scrollView.pagingEnabled = YES;
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [self.scrollView addSubview:self.contentView];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.scrollView);
        make.width.equalTo(self.scrollView);
        make.height.greaterThanOrEqualTo(@0.f);
    }];
    [self.scrollView addSubview:self.bgView];
    [self.scrollView addSubview:self.leftImgView];
    self.leftImgView.image = [UIImage imageNamed:self.leftModel.icon];
    [self.leftImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_centerX).offset(-25);
        make.top.equalTo(self.scrollView).offset(20);
        make.width.height.mas_equalTo(100);
    }];
    [self.scrollView addSubview:self.rightImgView];
    self.rightImgView.image = [UIImage imageNamed:self.rightModel.icon];
    [self.rightImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_centerX).offset(25);
        make.top.width.height.equalTo(self.leftImgView);
    }];
    self.leftTitleLabel.text = [self.pModel.male stringByAppendingString:@"男"];
    [self.leftTitleLabel sizeToFit];
    [self.view addSubview:self.leftTitleLabel];
    [self.leftTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.leftImgView.mas_bottom).offset(5);
        make.centerX.equalTo(self.leftImgView);
        make.width.mas_equalTo(100);
    }];
    self.rightTitleLabel.text = [self.pModel.female stringByAppendingString:@"女"];
    [self.rightTitleLabel sizeToFit];
    [self.view addSubview:self.rightTitleLabel];
    [self.rightTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.width.equalTo(self.leftTitleLabel);
        make.centerX.equalTo(self.rightImgView);
    }];
    self.descLabel.text = self.pModel.desc;
    [self.scrollView addSubview:self.descLabel];
    [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.equalTo(self.scrollView);
        make.top.equalTo(self.leftTitleLabel.mas_bottom).offset(30);
    }];
    UILabel *lab0;
    NSArray *item0Array = self.pModel.moreArray[0];
    for (int i = 0; i < item0Array.count; i++) {
        NSDictionary *dic = item0Array[i];
        UILabel *label = [[UILabel alloc] init];
        label.numberOfLines = 0;
        label.lineBreakMode = NSLineBreakByWordWrapping;
        label.font = [UIFont systemFontOfSize:14.];
        NSString *str = [NSString stringWithFormat:@"%@ %@", dic.allKeys[0], dic.allValues[0]];
        NSRange range0 = NSMakeRange(0, [dic.allKeys[0] length]);
        NSRange range1 = NSMakeRange(str.length - [dic.allValues[0] length], [dic.allValues[0] length]);
        NSArray *arr = @[@{@"color": UIColorFromRGBA(0xffffff, .6), @"range": NSStringFromRange(range0)}, @{@"color": UIColorFromRGB(0xffffff), @"range": NSStringFromRange(range1)}];
        label.attributedText = [NSAttributedString transWithString:str colorAttributeName:arr lineSpace:0.];
        [self.scrollView addSubview:label];
        [label sizeToFit];
        label.tag = 10000 + i;
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            if (!lab0) {
                make.left.equalTo(self.bgView).offset(20);
                make.top.equalTo(self.descLabel.mas_bottom).offset(30);
                make.width.mas_equalTo(110);
            }else {
                if (i % 2 != 0) {
                    make.left.equalTo(lab0.mas_right).offset(10);
                    make.top.equalTo(lab0);
                    make.right.equalTo(self.bgView).offset(-20);
                }else {
                    make.left.equalTo(self.bgView).offset(20);
                    make.top.equalTo(lab0.mas_bottom).offset(10);
                    make.width.mas_equalTo(110);
                }
            }
        }];
        lab0 = label;
    }
    UILabel *lab1;
    NSArray *item1Array = self.pModel.moreArray[1];
    for (int i = 0; i < item1Array.count; i++) {
        NSDictionary *dic = item1Array[i];
        UILabel *label = [[UILabel alloc] init];
        label.numberOfLines = 0;
        label.font = [UIFont systemFontOfSize:15.];
        NSString *str = [NSString stringWithFormat:@"%@:\n%@", dic.allKeys[0], dic.allValues[0]];
        NSRange range0 = NSMakeRange(0, [dic.allKeys[0] length] + 1);
        NSRange range1 = NSMakeRange(str.length - [dic.allValues[0] length], [dic.allValues[0] length]);
        NSArray *arr = @[@{@"color": [UIColor whiteColor], @"range": NSStringFromRange(range0)}, @{@"color": UIColorFromRGBA(0xffffff, .6), @"range": NSStringFromRange(range1)}];
        label.attributedText = [NSAttributedString transWithString:str colorAttributeName:arr lineSpace:8.];
        label.tag = 11000 + i;
        [self.scrollView addSubview:label];
        [label sizeToFit];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            if (!lab1) {
                make.top.equalTo(lab0.mas_bottom).offset(30);
            }else {
                make.top.equalTo(lab1.mas_bottom).offset(30);
            }
            make.left.equalTo(self.bgView).offset(20);
            make.right.equalTo(self.bgView).offset(-20);
        }];
        lab1 = label;
    }
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.scrollView).offset(10);
        make.top.equalTo(self.leftImgView.mas_centerY).offset(-8);
        make.right.equalTo(self.scrollView).offset(-10);
        make.bottom.equalTo(lab1).offset(30);
    }];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.bgView).offset(30);
    }];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.bgView).offset(30);
    }];
}
@end
