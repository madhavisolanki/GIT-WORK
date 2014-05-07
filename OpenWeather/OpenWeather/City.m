

#import "City.h"
#import "CityData.h"

@implementation City
@synthesize arraycityData;
@synthesize cityName;
- (id)initWithArrayCityData: (NSArray *)array setCityName:(NSString *)city
{
    if ((self = [super init]) == nil)
    {
        return nil;
    }
    arraycityData = [[NSMutableArray alloc] init];

    for (NSDictionary *dict in array) {
        CityData *fundamentalData = [[CityData alloc]
                                     initWithJSON: dict];
        self.cityName = city;
        fundamentalData.cityName = self.cityName;
        [arraycityData addObject:fundamentalData];
    }
    
    return self;
}


@end
