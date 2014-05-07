

#import "CityCollectionViewCell.h"

@implementation CityCollectionViewCell
@synthesize labelDate;
@synthesize labelTittle;
@synthesize labelWeatherDetail;

- (id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        
        UIView *bgView = [[UIView alloc] initWithFrame:self.backgroundView.frame];
        bgView.backgroundColor = [UIColor blueColor];
        bgView.layer.borderColor = [[UIColor whiteColor] CGColor];
        bgView.layer.borderWidth = 4;
        self.selectedBackgroundView = bgView;

    }
    
    return self;
}

@end
