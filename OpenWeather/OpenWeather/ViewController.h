

#import <UIKit/UIKit.h>
#import "CityListViewController.h"
#import "CollectionViewController.h"

@interface ViewController : UIViewController<UIScrollViewDelegate,UITableViewDelegate,CityListViewController,CollectionViewControllerDelegate>

#pragma mark - Custom method
-(void)dismissPopOverView;
@end
