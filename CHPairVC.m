#import "CHPairVC.h"
#import "CHPairDetailVC.h"
#import "Masonry.h"
#import "CHDefine.h"
#import "ConstellationModel.h"
@interface CHPairVC ()<UIPickerViewDelegate, UIPickerViewDataSource>
@property (nonatomic, strong) UIButton *startBtn;
@property (nonatomic, strong) UILabel *leftTitleLabel;
@property (nonatomic, strong) UILabel *rightTitleLabel;
@property (nonatomic, strong) UIImageView *leftImgView;
@property (nonatomic, strong) UIImageView *rightImgView;
@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) NSMutableArray *pickDataArray;
@property (nonatomic, assign) NSInteger leftSelIndex;
@property (nonatomic, assign) NSInteger rightSelIndex;
@end
@implementation CHPairVC
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"星座配对";
    [self initData];
    [self setupUI];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark - Lazy load
- (UIButton *)startBtn {
    if (nil == _startBtn) {
        _startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _startBtn.layer.cornerRadius = 32.f;
        _startBtn.layer.masksToBounds = YES;
        _startBtn.backgroundColor = UIColorFromRGB(0x99e1e5);
        _startBtn.titleLabel.font = [UIFont systemFontOfSize:22];
        [_startBtn setTitle:@"开始配对" forState:UIControlStateNormal];
        [_startBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_startBtn addTarget:self action:@selector(startBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _startBtn;
}
- (UILabel *)leftTitleLabel {
    if (nil == _leftTitleLabel) {
        _leftTitleLabel = [[UILabel alloc] init];
        _leftTitleLabel.layer.cornerRadius = 16.f;
        _leftTitleLabel.layer.masksToBounds = YES;
        _leftTitleLabel.text = @"白羊座";
        _leftTitleLabel.textColor = [UIColor whiteColor];
        _leftTitleLabel.font = [UIFont systemFontOfSize:16];
        _leftTitleLabel.textAlignment = NSTextAlignmentCenter;
        _leftTitleLabel.backgroundColor = UIColorFromRGB(0x75c2f6);
    }
    return _leftTitleLabel;
}
- (UILabel *)rightTitleLabel {
    if (nil == _rightTitleLabel) {
        _rightTitleLabel = [[UILabel alloc] init];
        _rightTitleLabel.layer.cornerRadius = 16.f;
        _rightTitleLabel.layer.masksToBounds = YES;
        _rightTitleLabel.text = @"白羊座";
        _rightTitleLabel.textColor = [UIColor whiteColor];
        _rightTitleLabel.font = [UIFont systemFontOfSize:16];
        _rightTitleLabel.textAlignment = NSTextAlignmentCenter;
        _rightTitleLabel.backgroundColor = UIColorFromRGB(0xff7a8a);
    }
    return _rightTitleLabel;
}
- (UIImageView *)leftImgView {
    if (nil == _leftImgView) {
        _leftImgView = [[UIImageView alloc] init];
        _leftImgView.layer.masksToBounds = YES;
        _leftImgView.layer.cornerRadius = 60.f;
        _leftImgView.image = [UIImage imageNamed:@"baiyang"];
        _leftImgView.backgroundColor = UIColorFromRGB(0x75c2f6);
        _leftImgView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showPickerView)];
        [_leftImgView addGestureRecognizer:tapGes];
    }
    return _leftImgView;
}
- (UIImageView *)rightImgView {
    if (nil == _rightImgView) {
        _rightImgView = [[UIImageView alloc] init];
        _rightImgView.layer.masksToBounds = YES;
        _rightImgView.layer.cornerRadius = 60.f;
        _rightImgView.image = [UIImage imageNamed:@"baiyang"];
        _rightImgView.backgroundColor = UIColorFromRGB(0xff7a8a);
        _rightImgView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showPickerView)];
        [_rightImgView addGestureRecognizer:tapGes];
    }
    return _rightImgView;
}
- (UIPickerView *)pickerView {
    if (nil == _pickerView) {
        _pickerView = [[UIPickerView alloc] init];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
        _pickerView.hidden = YES;
        _pickerView.showsSelectionIndicator = YES;
        _pickerView.backgroundColor = [UIColor whiteColor];
        [_pickerView selectRow:0 inComponent:0 animated:YES];
        [_pickerView selectRow:0 inComponent:1 animated:YES];
    }
    return _pickerView;
}
- (NSMutableArray *)pickDataArray {
    if (nil == _pickDataArray) {
        _pickDataArray = [NSMutableArray array];
    }
    return _pickDataArray;
}
#pragma mark - Private method
- (void)initData {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Constellation" ofType:@"plist"];
    NSArray *arr = [NSArray arrayWithContentsOfFile:filePath];
    for (NSDictionary *dic in arr) {
        ConstellationModel *cModel = [[ConstellationModel alloc] initWithDic:dic];
        [self.pickDataArray addObject:cModel];
    }
    self.leftSelIndex = 0;
    self.rightSelIndex = 0;
}
- (void)setupUI {
    UILabel *label = [[UILabel alloc] init];
    label.text = @"点击下面的星座图可选择心仪的星座配对哦～";
    label.numberOfLines = 0;
    label.textColor = [UIColor blackColor];
    label.font = [UIFont systemFontOfSize:17];
    label.textAlignment = NSTextAlignmentCenter;
    [label sizeToFit];
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(60);
        make.left.width.equalTo(self.view);
    }];
    [self.view addSubview:self.leftImgView];
    [self.leftImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_centerX).offset(-25);
        make.top.equalTo(label.mas_bottom).offset(50);
        make.width.height.mas_equalTo(120);
    }];
    [self.leftTitleLabel sizeToFit];
    [self.view addSubview:self.leftTitleLabel];
    [self.leftTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.leftImgView.mas_bottom).offset(14);
        make.centerX.equalTo(self.leftImgView);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(32);
    }];
    [self.view addSubview:self.rightImgView];
    [self.rightImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_centerX).offset(25);
        make.top.width.height.equalTo(self.leftImgView);
    }];
    [self.rightTitleLabel sizeToFit];
    [self.view addSubview:self.rightTitleLabel];
    [self.rightTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.width.height.equalTo(self.leftTitleLabel);
        make.centerX.equalTo(self.rightImgView);
    }];
    [self.view addSubview:self.startBtn];
    [self.startBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.leftTitleLabel.mas_bottom).offset(60);
        make.centerX.mas_equalTo(self.view);
        make.width.mas_equalTo(264);
        make.height.mas_equalTo(64);
    }];
    [self.view addSubview:self.pickerView];
    [self.pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.bottom.equalTo(self.view);
        make.height.mas_equalTo(200);
    }];
}
- (void)startBtnClicked {
    self.pickerView.hidden = YES;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        CHPairDetailVC *vc = [[CHPairDetailVC alloc] init];
        vc.leftModel = self.pickDataArray[self.leftSelIndex];
        vc.rightModel = self.pickDataArray[self.rightSelIndex];
        [self.navigationController pushViewController:vc animated:YES];
    });
}
- (void)showPickerView {
    self.pickerView.hidden = NO;
}
#pragma mark - UIPickerViewDelegate
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 40.;
}
- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    ConstellationModel *model = self.pickDataArray[row];
    return model.name;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    [pickerView selectRow:row inComponent:component animated:YES];
    ConstellationModel *model = self.pickDataArray[row];
    if (component == 0) {
        self.leftImgView.image = [UIImage imageNamed:model.icon];
        self.leftTitleLabel.text = model.name;
        self.leftSelIndex = row;
    }else {
        self.rightImgView.image = [UIImage imageNamed:model.icon];
        self.rightTitleLabel.text = model.name;
        self.rightSelIndex = row;
    }
}
#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.pickDataArray.count;
}
@end
