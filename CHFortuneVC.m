#import "CHFortuneVC.h"
#import "Masonry.h"
#import "CHDefine.h"
#import "CHConfig.h"
#import "ConstellationModel.h"
#import "CHFortuneDetailVC.h"
#import "CHFortuneCell.h"
@interface CHFortuneVC ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@end
@implementation CHFortuneVC
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"星座运势";
    [self initData];
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
#pragma mark - Private method
- (void)initData {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Constellation" ofType:@"plist"];
    NSArray *arr = [NSArray arrayWithContentsOfFile:filePath];
    for (NSDictionary *dic in arr) {
        ConstellationModel *cModel = [[ConstellationModel alloc] initWithDic:dic];
        [self.dataArray addObject:cModel];
    }
}
- (void)setupUI {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = UIColorFromRGB(0xfae3e3);
    [self.collectionView registerClass:[CHFortuneCell class] forCellWithReuseIdentifier:@"CHFortunneCell"];
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}
#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CHFortuneCell *myCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CHFortunneCell" forIndexPath:indexPath];
    [myCell setBackgroundColor:[UIColor whiteColor]];
    [myCell configModel:self.dataArray[indexPath.row]];
    return myCell;
}
#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    CHFortuneDetailVC *vc = [[CHFortuneDetailVC alloc] init];
    vc.cModel = self.dataArray[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - UICollectionViewDelegateFlowLayout
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return  CGSizeMake(100, 140);
}
- (UIEdgeInsets) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(30, 40, 30, 40);
}
- (CGFloat) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}
- (CGFloat) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 30;
}
@end
