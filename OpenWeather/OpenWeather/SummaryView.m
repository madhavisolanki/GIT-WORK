

#import "SummaryView.h"

@implementation SummaryView
@synthesize lblEveTemp;
@synthesize lblMaxTemp;
@synthesize lblMinTemp;
@synthesize lblMorTemp;
@synthesize lblNigTemp;
@synthesize lblTemp;
@synthesize lblTtile;
@synthesize lblCityName;
@synthesize lblDate;
@synthesize imageBG;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
