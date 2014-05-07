
#import <UIKit/UIKit.h>
#import "City.h"
#import "CityData.h"

@protocol CollectionViewControllerDelegate <NSObject>

@required

- (void)selectedData:(CityData *)cityData;

@end


@interface CollectionViewController : UICollectionViewController<UICollectionViewDelegate,UICollectionViewDataSource>
{

}
@property (weak) id <CollectionViewControllerDelegate> delegate;

@property(nonatomic,strong)City *city;
@end
