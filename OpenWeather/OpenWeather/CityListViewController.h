

#import <UIKit/UIKit.h>

@protocol CityListViewController <NSObject>

@required

- (void)dismissPopOver:(NSString *)cityName;

@end

@interface CityListViewController : UITableViewController<UISearchBarDelegate>
{
}
@property (weak) id <CityListViewController> delegate;
@end
