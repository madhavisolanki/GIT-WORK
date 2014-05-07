

#import "ViewController.h"
#import "TestServiceManager.h"
#import "TestServiceClient.h"
#import "Cities.h"
#import "SummaryView.h"

#pragma mark - Private Methods

@interface ViewController ()
{
@private __strong NSArray *_contentList;
    
@private __weak UIPopoverController *popOver;
}

@property(nonatomic, weak) IBOutlet UITextField *textField;
@property(nonatomic,weak)IBOutlet SummaryView *viewSummary;
@property(nonatomic,weak)IBOutlet UIView *viewCollection;
@property(nonatomic,weak)IBOutlet UIScrollView *scrollView;
@property(nonatomic,weak)IBOutlet UIPageControl *pageControl;


@property(nonatomic,strong)NSMutableDictionary *viewControllers;
@property (nonatomic, strong) NSArray *contentList;
@property (nonatomic, strong) Cities *cities;
@property(nonatomic,assign)int pageNumber;

-(IBAction)addCity:(id)sender;

@end

@implementation ViewController

@synthesize textField = _textField;
@synthesize viewCollection = _viewCollection;
@synthesize viewSummary = _viewSummary;
@synthesize scrollView = _scrollView;
@synthesize viewControllers = _viewControllers;
@synthesize contentList;
@synthesize cities = _cities;
@synthesize pageControl = _pageControl;
@synthesize pageNumber = _pageNumber;

#pragma mark - View Lifestyle

- (void)viewDidLoad
{
    _scrollView.delegate = self;
    _pageNumber = 0;
    _viewControllers = [[NSMutableDictionary alloc] init];
    _cities= [Cities sharedInstance];
    _pageControl.numberOfPages = 0;
    _pageControl.hidden = TRUE;
    _viewSummary.hidden = TRUE;
    
    [super viewDidLoad];
}

#pragma mark  - IBAction

-(IBAction)addCity:(id)sender
{
    if (popOver)
    {
        [popOver dismissPopoverAnimated:YES];
    }
    
    [self performSegueWithIdentifier:@"CityListViewController" sender:sender];

}

#pragma mark - Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([segue.identifier isEqualToString:@"CityListViewController"])
	{
        CityListViewController *flickrPhotoViewController = segue.destinationViewController;
        flickrPhotoViewController.delegate = self;
        if (popOver)
        {
            [popOver dismissPopoverAnimated:YES];
        }
        popOver = [(UIStoryboardPopoverSegue *)segue popoverController];

	}
}

#pragma mark - PopOver

-(void)dismissPopOverView
{
    if (popOver) {
        [popOver dismissPopoverAnimated:YES];
    }
    
}

#pragma mark - ScrollView Delegate

- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    CGFloat pageWidth = _scrollView.frame.size.width;
    int page = floor((sender.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    _pageControl.currentPage = page;
}

// At the begin of scroll dragging, reset the boolean used when scrolls originate from the UIPageControl
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self dismissPopOverView];
}

// At the end of scroll animation, reset the boolean used when scrolls originate from the UIPageControl
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
}

#pragma mark - CityList Delegate
- (void)dismissPopOver:(NSString *)cityName
{
    [self dismissPopOverView];
    
    City *objcity = [_cities.cities valueForKey:cityName];//check for duplicate
    if (objcity) {
        return;
    }
    
    TestServiceManager *_serviceManager= [TestServiceManager sharedInstance];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [_serviceManager getDataWithCityName:cityName completion: ^(TestServiceResult *result, City *city)
     {
         
         [[NSOperationQueue mainQueue] addOperationWithBlock: ^ {
             [_cities.cities setValue:city forKey:cityName];
             [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
             
             CityData *cityData = [city.arraycityData objectAtIndex:0];
             [self selectedData:cityData];
             [self addCityData:cityName];
         }];
     }];
    
}

-(void)addCityData:(NSString *)CityName;
{
    CollectionViewController *collectionViewController = (CollectionViewController *)[_viewControllers valueForKey:CityName];
    
    if (collectionViewController == nil || [[_viewControllers allKeys] count]==0)
    {
        collectionViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"CollectionViewController"];
        [_viewControllers setValue:collectionViewController forKey:CityName];
        collectionViewController.delegate = self;
        _pageNumber = _pageNumber + 1;
        _pageControl.numberOfPages = _pageNumber;
        _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width * _pageNumber, _scrollView.frame.size.height);
        _viewSummary.hidden = FALSE;
        
    }
    else
    {
        [collectionViewController removeFromParentViewController];
        collectionViewController = nil;
        collectionViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"CollectionViewController"];
        [_viewControllers setValue:collectionViewController forKey:CityName];
        collectionViewController.delegate = self;
    }
    
    if ([collectionViewController inputView] == nil)
    {
        CGRect frame = _scrollView.frame;
        int numberofPages = [[_viewControllers allKeys] count]-1;
        
        frame.origin.x = frame.size.width * numberofPages;
        frame.origin.y = 0;
        collectionViewController.city = [_cities.cities valueForKey:CityName];
        [_scrollView setContentOffset:frame.origin];
        collectionViewController.view.frame = frame;
        [_scrollView addSubview:collectionViewController.view];
        
    }
}

#pragma mark - Touches

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self dismissPopOverView];
}

#pragma mark - CollectionViewDelegate

- (void)selectedData:(CityData *)cityData
{
    _viewSummary.lblTtile.text = cityData.description;
    _viewSummary.lblEveTemp.text = cityData.eveTemperature;
    _viewSummary.lblMaxTemp.text = cityData.maxTemperature;
    _viewSummary.lblMinTemp.text = cityData.minTemperature;
    _viewSummary.lblMorTemp.text = cityData.morTemperature;
    _viewSummary.lblNigTemp.text = cityData.nightTemperature;
    _viewSummary.lblTemp.text = cityData.dayTemperature;
    _viewSummary.lblCityName.text = cityData.cityName;
    _viewSummary.lblDate.text = cityData.displayDate;
}

#pragma mark - Memory Management

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
