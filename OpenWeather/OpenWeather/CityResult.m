

#import "CityResult.h"
#import "OpenWeatherDefines.h"

@implementation CityResult
- (id)initWithJSON: (NSDictionary *)json
{
	// Abort if base initializer fails.
	if ((self = [super init]) == nil)
	{
		return nil;
	}
    NSArray *array = [json objectForKey:OPEN_WEA_API_JSON_KEY_TERMS];
    self.cityName = [[array objectAtIndex:0] objectForKey:OPEN_WEA_API_JSON_KEY_VAL];
    return self;
}
@end
