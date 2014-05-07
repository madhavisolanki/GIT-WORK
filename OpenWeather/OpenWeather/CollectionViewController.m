
#import "CollectionViewController.h"
#import "CityCollectionViewCell.h"
#import "CityData.h"

#pragma mark - Private Methods


@interface CollectionViewController ()
@end

@implementation CollectionViewController
@synthesize city;
@synthesize delegate;

#pragma mark - init

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
    }
    return self;
}

#pragma mark - View Lifestyle

- (void)viewDidLoad
{
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"MY_CELL"];

    [self.collectionView setBackgroundColor:[UIColor clearColor]];

    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark - UICollectionView Datasource
- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section;
{
    return [city.arraycityData count];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CityCollectionViewCell *cell = [cv dequeueReusableCellWithReuseIdentifier:@"CityCollectionViewCell" forIndexPath:indexPath];
    
    CityData *data = [city.arraycityData objectAtIndex:indexPath.row];
    
    cell.labelTittle.text = data.description;
    cell.labelWeatherDetail.text = [NSString stringWithFormat:@"%@ celcius",data.dayTemperature];
    cell.labelDate.text = data.displayDate;

    return cell;

}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [delegate selectedData:[city.arraycityData objectAtIndex:indexPath.row]];
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(50, 20, 50, 20);
}

#pragma mark - Memory Management

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
