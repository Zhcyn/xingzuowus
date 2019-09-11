#import "CHSearchVC.h"
#import "Masonry.h"
#import "CHDefine.h"
#import "CHSearchResultVC.h"
#import "Toast.h"
@interface CHSearchVC ()
@property (nonatomic, strong) UIButton *selDateBtn;
@property (nonatomic, strong) UIButton *searchBtn;
@property (nonatomic, strong) UIDatePicker *datePicker;
@end
@implementation CHSearchVC
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"星座查询";
    [self setupUI];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (UIButton *)selDateBtn {
    if (nil == _selDateBtn) {
        _selDateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _selDateBtn.layer.cornerRadius = 32.f;
        _selDateBtn.layer.masksToBounds = YES;
        _selDateBtn.backgroundColor = [UIColor whiteColor];
        [_selDateBtn setTitle:@"请选择出生日期" forState:UIControlStateNormal];
        [_selDateBtn setTitleColor:UIColorFromRGB(0x666666) forState:UIControlStateNormal];
        [_selDateBtn addTarget:self action:@selector(selDateBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selDateBtn;
}
- (UIButton *)searchBtn {
    if (nil == _searchBtn) {
        _searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _searchBtn.layer.cornerRadius = 32.f;
        _searchBtn.layer.masksToBounds = YES;
        _searchBtn.backgroundColor = [UIColor whiteColor];
        [_searchBtn setTitle:@"开始查询" forState:UIControlStateNormal];
        [_searchBtn setTitleColor:UIColorFromRGB(0x000000) forState:UIControlStateNormal];
        [_searchBtn addTarget:self action:@selector(searchBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _searchBtn;
}
- (UIDatePicker *)datePicker {
    if (nil == _datePicker) {
        _datePicker = [[UIDatePicker alloc] init];
        _datePicker.locale = [NSLocale localeWithLocaleIdentifier:@"zh"];
        _datePicker.datePickerMode = UIDatePickerModeDate;
        _datePicker.date = [NSDate date];
        _datePicker.maximumDate = [NSDate date];
        _datePicker.backgroundColor = [UIColor whiteColor];
        [_datePicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return _datePicker;
}
#pragma mark - Private method
- (void)setupUI {
    [self.view addSubview:self.selDateBtn];
    [self.selDateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(240);
        make.height.mas_equalTo(64);
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(120);
    }];
    [self.view addSubview:self.searchBtn];
    [self.searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(240);
        make.height.mas_equalTo(64);
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.selDateBtn.mas_bottom).offset(30);
    }];
    self.datePicker.hidden = YES;
    [self.view addSubview:_datePicker];
    [_datePicker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.width.equalTo(self.view);
        make.height.mas_equalTo(300);
    }];
}
- (void)selDateBtnClicked {
    self.datePicker.hidden = NO;
}
- (void)searchBtnClicked {
    if ([self.selDateBtn.titleLabel.text isEqualToString:@"请选择出生日期"]) {
        [self.view makeToast:@"请选择出生日期再查询" duration:1.f position:CSToastPositionCenter];
        return;
    }
    self.datePicker.hidden = YES;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        CHSearchResultVC *vc = [[CHSearchResultVC alloc] init];
        vc.dateStr = self.selDateBtn.titleLabel.text;
        [self.navigationController pushViewController:vc animated:YES];
    });
}
- (void)dateChanged:(UIDatePicker *)datePicker {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy年MM月dd日";
    NSString *dateStr = [formatter  stringFromDate:datePicker.date];
    [self.selDateBtn setTitle:dateStr forState:UIControlStateNormal];
    [self.selDateBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
}
@end
