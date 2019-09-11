#import <UIKit/UIKit.h>
@interface CHBaseVC : UIViewController
- (UIButton *)loadBackBtn;
- (UITableView *)addNormalList;
- (UITableView *)addNormalListWithStyle:(UITableViewStyle)style;
- (UIScrollView *)addNormalScrollView;
@end
