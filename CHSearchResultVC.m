#import "CHSearchResultVC.h"
#import "Masonry.h"
#import "CHDefine.h"
#import "ConstellationModel.h"
#import "NSDate+EX.h"
#import "NSAttributedString+EX.h"
@interface CHSearchResultVC ()
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UILabel *topLabel;
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) ConstellationModel *cModel;
@end
@implementation CHSearchResultVC
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"查询结果";
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Constellation" ofType:@"plist"];
    NSArray *arr = [NSArray arrayWithContentsOfFile:filePath];
    NSString *constellationName = [[NSDate date] getConstellationWithDate: self.dateStr];
    for (NSDictionary *dic in arr) {
        if ([dic[@"name"] isEqualToString:constellationName]) {
            self.cModel = [[ConstellationModel alloc] initWithDic:dic];
        }
    }
    [self setupUI];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark - Lazy load
- (UILabel *)topLabel {
    if (nil == _topLabel) {
        _topLabel = [[UILabel alloc] init];
        _topLabel.textColor = [UIColor blackColor];
        _topLabel.font = [UIFont systemFontOfSize:18];
        _topLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _topLabel;
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
- (UILabel *)nameLabel {
    if (nil == _nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textColor = [UIColor blueColor];
        _nameLabel.font = [UIFont boldSystemFontOfSize:22.];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _nameLabel;
}
- (UILabel *)dateLabel {
    if (nil == _dateLabel) {
        _dateLabel = [[UILabel alloc] init];
        _dateLabel.textColor = [UIColor blueColor];
        _dateLabel.textAlignment = NSTextAlignmentCenter;
        _dateLabel.font = [UIFont systemFontOfSize:16.];
    }
    return _dateLabel;
}
- (UIView *)contentView {
    if (nil == _contentView) {
        _contentView = [[UIView alloc] init];
    }
    return _contentView;
}
#pragma mark - Private method
- (void)setupUI {
    self.scrollView = [self addNormalScrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [self.scrollView addSubview:self.contentView];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.scrollView);
        make.width.equalTo(self.scrollView);
        make.height.greaterThanOrEqualTo(@0.f);
    }];
    self.topLabel.text = [self.dateStr stringByAppendingString:@"出生"];
    [self.scrollView addSubview:self.topLabel];
    [self.topLabel sizeToFit];
    [self.topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.equalTo(self.scrollView);
        make.top.equalTo(self.scrollView).offset(26);
    }];
    [self.scrollView addSubview:self.bgView];
    self.imgView.image = [UIImage imageNamed:self.cModel.icon];
    [self.scrollView addSubview:self.imgView];
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.bgView.mas_top);
        make.left.equalTo(self.scrollView).offset(8);
        make.width.height.mas_equalTo(120);
    }];
    self.nameLabel.text = self.cModel.name;
    [self.scrollView addSubview:self.nameLabel];
    [self.nameLabel sizeToFit];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.equalTo(self.scrollView);
        make.top.equalTo(self.imgView.mas_centerY).offset(20);
    }];
    self.dateLabel.text = self.cModel.dateStr;
    [self.scrollView addSubview:self.dateLabel];
    [self.dateLabel sizeToFit];
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.nameLabel);
        make.top.equalTo(self.nameLabel.mas_bottom).offset(10);
    }];
    UILabel *lab0;
    UIView *lineView0;
    NSArray *item0Array = self.cModel.moreArray[0];
    for (int i = 0; i < item0Array.count; i++) {
        NSDictionary *dic = item0Array[i];
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:14.];
        NSString *str = [NSString stringWithFormat:@"%@：%@", dic.allKeys[0], dic.allValues[0]];
        NSRange range0 = NSMakeRange(0, [dic.allKeys[0] length]);
        NSRange range1 = NSMakeRange(str.length - [dic.allValues[0] length], [dic.allValues[0] length]);
        NSArray *arr = @[@{@"color": UIColorFromRGB(0x999999), @"range": NSStringFromRange(range0)}, @{@"color": UIColorFromRGB(0x000000), @"range": NSStringFromRange(range1)}];
        label.attributedText = [NSAttributedString transWithString:str colorAttributeName:arr lineSpace:0.];
        [self.scrollView addSubview:label];
        [label sizeToFit];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            if (!lab0) {
                make.left.equalTo(self.bgView).offset(20);
                make.top.equalTo(self.dateLabel.mas_bottom).offset(20);
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
    UIView *lineView1;
    NSArray *item1Array = self.cModel.moreArray[1];
    for (int i = 0; i < item1Array.count; i++) {
        NSDictionary *dic = item1Array[i];
        UILabel *label = [[UILabel alloc] init];
        label.numberOfLines = 0;
        label.font = [UIFont systemFontOfSize:15.];
        NSString *str = [NSString stringWithFormat:@"%@:  %@", dic.allKeys[0], dic.allValues[0]];
        UIColor *color;
        if (i == 0) {
            color = [UIColor redColor];
        }else if (i == 1) {
            color = [UIColor blueColor];
        }else {
            color = [UIColor orangeColor];
        }
        NSRange range0 = NSMakeRange(0, [dic.allKeys[0] length]);
        NSRange range1 = NSMakeRange(str.length - [dic.allValues[0] length], [dic.allValues[0] length]);
        NSArray *arr = @[@{@"color": color, @"range": NSStringFromRange(range0)}, @{@"color": UIColorFromRGB(0x000000), @"range": NSStringFromRange(range1)}];
        label.attributedText = [NSAttributedString transWithString:str colorAttributeName:arr lineSpace:0.];
        [self.scrollView addSubview:label];
        [label sizeToFit];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            if (!lab1) {
                make.top.equalTo(lineView0.mas_bottom).offset(20);
            }else {
                make.top.equalTo(lab1.mas_bottom).offset(14);
            }
            make.left.equalTo(self.bgView).offset(18);
            make.right.equalTo(self.bgView).offset(-18);
        }];
        lab1 = label;
        if (i == item1Array.count - 1) {
            lineView1 = [[UIView alloc] init];
            lineView1.backgroundColor = UIColorFromRGB(0xeaeaea);
            [self.scrollView addSubview:lineView1];
            [lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.bgView).offset(18);
                make.right.equalTo(self.bgView).offset(-18);
                make.height.mas_equalTo(1);
                make.top.equalTo(lab1.mas_bottom).offset(20);
            }];
        }
    }
    UILabel *lab2;
    NSArray *item2Array = self.cModel.moreArray[2];
    for (int i = 0; i < item2Array.count; i++) {
        NSDictionary *dic = item2Array[i];
        UILabel *label = [[UILabel alloc] init];
        label.numberOfLines = 0;
        label.lineBreakMode = NSLineBreakByWordWrapping;
        label.font = [UIFont systemFontOfSize:15.];
        NSString *str = [NSString stringWithFormat:@"%@:\n%@", dic.allKeys[0], dic.allValues[0]];
        NSRange range0 = NSMakeRange(0, [dic.allKeys[0] length]);
        NSRange range1 = NSMakeRange(str.length - [dic.allValues[0] length], [dic.allValues[0] length]);
        NSArray *arr = @[@{@"color": [UIColor blueColor], @"range": NSStringFromRange(range0)}, @{@"color": UIColorFromRGB(0x000000), @"range": NSStringFromRange(range1)}];
        label.attributedText = [NSAttributedString transWithString:str colorAttributeName:arr lineSpace:10];;
        [self.scrollView addSubview:label];
        [label sizeToFit];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            if (!lab2) {
                make.top.equalTo(lineView1.mas_bottom).offset(20);
            }else {
                make.top.equalTo(lab2.mas_bottom).offset(24);
            }
            make.left.equalTo(self.bgView).offset(18);
            make.right.equalTo(self.bgView).offset(-18);
        }];
        lab2 = label;
    }
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.scrollView).offset(10);
        make.top.equalTo(self.topLabel.mas_bottom).offset(26);
        make.right.equalTo(self.scrollView).offset(-10);
        make.bottom.equalTo(lab2).offset(20);
    }];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.bgView).offset(30);
    }];
}
@end
