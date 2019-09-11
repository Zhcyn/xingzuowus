#import "CHFortuneDetailVC.h"
#import "Masonry.h"
#import "CHDefine.h"
#import "ConstellationModel.h"
#import "CHFortuneModel.h"
#import "NSDate+EX.h"
#import "NSAttributedString+EX.h"
@interface CHFortuneDetailVC ()
@property (nonatomic, strong) UIButton *changeBtn;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *indexsLabel;
@property (nonatomic, strong) UILabel *descLabel;
@property (nonatomic, strong) CHFortuneModel *fModel;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, assign) NSInteger curIndex;
@end
@implementation CHFortuneDetailVC
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"星座运势详情";
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Fortune" ofType:@"plist"];
    NSArray *arr = [NSArray arrayWithContentsOfFile:filePath];
    for (NSDictionary *dic in arr) {
        if ([dic.allKeys[0] isEqualToString:self.cModel.name]) {
            for (NSArray *subArr in dic.allValues) {
                for (NSDictionary *subDic in subArr) {
                    CHFortuneModel *fModel = [[CHFortuneModel alloc] initWithDic:subDic];
                    [self.dataArray addObject:fModel];
                }
            }
        }
    }
    self.curIndex = 1;
    self.fModel = self.dataArray[self.curIndex];
    [self setupUI];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark - Lazy load
- (NSMutableArray *)dataArray {
    if (nil == _dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (UIButton *)changeBtn {
    if (nil == _changeBtn) {
        _changeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _changeBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_changeBtn setTitle:@"切换查看多样运势" forState:UIControlStateNormal];
        [_changeBtn setTitleColor:UIColorFromRGB(0xff7a8a) forState:UIControlStateNormal];
        [_changeBtn setImage:[UIImage imageNamed:@"change"] forState:UIControlStateNormal];
        [_changeBtn addTarget:self action:@selector(changeBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _changeBtn;
}
- (UIView *)contentView {
    if (nil == _contentView) {
        _contentView = [[UIView alloc] init];
    }
    return _contentView;
}
- (UIView *)bgView {
    if (nil == _bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = [UIColor whiteColor];
        _bgView.layer.cornerRadius = 10.f;
        _bgView.layer.masksToBounds = YES;
    }
    return _bgView;
}
- (UIImageView *)imgView {
    if (nil == _imgView) {
        _imgView = [[UIImageView alloc] init];
        _imgView.layer.masksToBounds = YES;
        _imgView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imgView;
}
- (UILabel *)indexsLabel {
    if (nil == _indexsLabel) {
        _indexsLabel = [[UILabel alloc] init];
        _indexsLabel.textColor = [UIColor blackColor];
        _indexsLabel.font = [UIFont systemFontOfSize:14];
    }
    return _indexsLabel;
}
- (UILabel *)descLabel {
    if (nil == _descLabel) {
        _descLabel = [[UILabel alloc] init];
        _descLabel.textColor = [UIColor blackColor];
        _descLabel.font = [UIFont systemFontOfSize:15];
    }
    return _descLabel;
}
- (UILabel *)nameLabel {
    if (nil == _nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textColor = UIColorFromRGB(0xff7a8a);
        _nameLabel.font = [UIFont boldSystemFontOfSize:22.];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _nameLabel;
}
- (UILabel *)dateLabel {
    if (nil == _dateLabel) {
        _dateLabel = [[UILabel alloc] init];
        _dateLabel.textColor = UIColorFromRGB(0x999999);
        _dateLabel.font = [UIFont systemFontOfSize:13.];
    }
    return _dateLabel;
}
#pragma mark - Private method
- (void)changeBtnClicked {
    if (self.curIndex == self.dataArray.count - 1) {
        self.curIndex = 0;
    }else {
        self.curIndex += 1;
        self.fModel = self.dataArray[self.curIndex];
    }
    [self updateUIWhenDataChange];
}
- (void)updateUIWhenDataChange {
    self.dateLabel.text = [NSString stringWithFormat:@"%@运势", self.fModel.dateStr];
    self.indexsLabel.text = self.fModel.integrateIndex;
    self.descLabel.text = self.fModel.integrateDesc;
    [self updateChangedUI];
}
- (void)updateChangedUI {
    for (UIView *sView in self.scrollView.subviews) {
        if (sView.tag >= 10000 && sView.tag < 19999) {
            [sView removeFromSuperview];
        }
    }
    UILabel *lab0;
    UIView *lineView0;
    NSArray *item0Array = self.fModel.moreArray[0];
    for (int i = 0; i < item0Array.count; i++) {
        NSDictionary *dic = item0Array[i];
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:14.];
        NSString *str = [NSString stringWithFormat:@"%@  %@", dic.allKeys[0], dic.allValues[0]];
        NSRange range0 = NSMakeRange(0, [dic.allKeys[0] length]);
        NSRange range1 = NSMakeRange(str.length - [dic.allValues[0] length], [dic.allValues[0] length]);
        NSArray *arr = @[@{@"color": UIColorFromRGB(0x999999), @"range": NSStringFromRange(range0)}, @{@"color": UIColorFromRGB(0x000000), @"range": NSStringFromRange(range1)}];
        label.attributedText = [NSAttributedString transWithString:str colorAttributeName:arr lineSpace:0.];
        [self.scrollView addSubview:label];
        [label sizeToFit];
        label.tag = 10000 + i;
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            if (!lab0) {
                make.left.equalTo(self.bgView).offset(20);
                make.top.equalTo(self.nameLabel.mas_bottom).offset(24);
                make.right.equalTo(self.scrollView.mas_centerX).offset(-10);
            }else {
                if (i % 2 != 0) {
                    make.left.equalTo(self.scrollView.mas_centerX).offset(10);
                    make.top.equalTo(lab0);
                    make.right.equalTo(self.scrollView);
                }else {
                    make.left.equalTo(self.bgView).offset(18);
                    make.top.equalTo(lab0.mas_bottom).offset(10);
                    make.right.equalTo(self.scrollView.mas_centerX).offset(-10);
                }
            }
        }];
        lab0 = label;
        if (i == item0Array.count - 1) {
            lineView0 = [[UIView alloc] init];
            lineView0.tag = 19000 + i;
            lineView0.backgroundColor = UIColorFromRGB(0xeaeaea);
            [self.scrollView addSubview:lineView0];
            [lineView0 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.bgView).offset(18);
                make.right.equalTo(self.bgView).offset(-18);
                make.height.mas_equalTo(1);
                make.top.equalTo(lab0.mas_bottom).offset(20);
            }];
        }
    }
    UILabel *lab1;
    NSArray *item1Array = self.fModel.moreArray[1];
    for (int i = 0; i < item1Array.count; i++) {
        NSDictionary *dic = item1Array[i];
        UILabel *label = [[UILabel alloc] init];
        label.numberOfLines = 0;
        label.font = [UIFont systemFontOfSize:15.];
        NSString *str = [NSString stringWithFormat:@"%@:\n%@", dic.allKeys[0], dic.allValues[0]];
        NSRange range0 = NSMakeRange(0, [dic.allKeys[0] length]);
        NSRange range1 = NSMakeRange(str.length - [dic.allValues[0] length], [dic.allValues[0] length]);
        NSArray *arr = @[@{@"color": UIColorFromRGB(0x000000), @"range": NSStringFromRange(range0)}, @{@"color": UIColorFromRGB(0x999999), @"range": NSStringFromRange(range1)}];
        label.attributedText = [NSAttributedString transWithString:str colorAttributeName:arr lineSpace:8.];
        label.tag = 11000 + i;
        [self.scrollView addSubview:label];
        [label sizeToFit];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            if (!lab1) {
                make.top.equalTo(lineView0.mas_bottom).offset(20);
            }else {
                make.top.equalTo(lab1.mas_bottom).offset(24);
            }
            make.left.equalTo(self.bgView).offset(18);
            make.right.equalTo(self.bgView).offset(-18);
        }];
        lab1 = label;
    }
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.scrollView).offset(10);
        make.top.equalTo(self.imgView.mas_centerY).offset(-8);
        make.right.equalTo(self.scrollView).offset(-10);
        make.bottom.equalTo(lab1).offset(30);
    }];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.bgView).offset(30);
    }];
}
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
    [self.scrollView addSubview:self.changeBtn];
    [self.changeBtn sizeToFit];
    [self.changeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.scrollView).offset(-20);
        make.top.equalTo(self.scrollView).offset(20);
        make.height.mas_equalTo(44);
    }];
    [self.scrollView addSubview:self.bgView];
    self.imgView.image = [UIImage imageNamed:self.cModel.icon];
    [self.scrollView addSubview:self.imgView];
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.scrollView).offset(10);
        make.left.equalTo(self.scrollView).offset(25);
        make.width.height.mas_equalTo(120);
    }];
    self.dateLabel.text = [NSString stringWithFormat:@"今日运势(%@)", [[NSDate date] stringWithFormate:@"yyyy-MM-dd"]];
    [self.scrollView addSubview:self.dateLabel];
    [self.dateLabel sizeToFit];
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgView.mas_right).offset(30);
        make.right.equalTo(self.scrollView).offset(-10);
        make.top.equalTo(self.imgView.mas_centerY).offset(10);
    }];
    self.indexsLabel.text = self.fModel.integrateIndex;
    [self.scrollView addSubview:self.indexsLabel];
    [self.indexsLabel sizeToFit];
    [self.indexsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.dateLabel);
        make.top.equalTo(self.dateLabel.mas_bottom).offset(10);
    }];
    self.descLabel.text = self.fModel.integrateDesc;
    [self.scrollView addSubview:self.descLabel];
    [self.descLabel sizeToFit];
    [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.indexsLabel);
        make.top.equalTo(self.indexsLabel.mas_bottom).offset(10);
    }];
    self.nameLabel.text = self.cModel.name;
    [self.scrollView addSubview:self.nameLabel];
    [self.nameLabel sizeToFit];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.imgView);
        make.centerY.equalTo(self.descLabel);
    }];
    [self updateChangedUI];
}
@end
