

#import "CityData.h"
#import "OpenWeatherDefines.h"

@interface CityData ()
{

}
-(void)setTemperature:(NSArray *)array;
@end

@implementation CityData
@synthesize date;
@synthesize description;
@synthesize cityName;
@synthesize dayTemperature;
@synthesize maxTemperature;
@synthesize minTemperature;
@synthesize morTemperature;
@synthesize eveTemperature;
@synthesize nightTemperature;
@synthesize pressure;
@synthesize humidity;
@synthesize averageTemp;
@synthesize displayDate;

- (id)initWithJSON: (NSDictionary *)json
{
    if ((self = [super init]) == nil)
	{
		return nil;
	}
    
    [self setTemperature:[json objectForKey:OPEN_WEA_API_JSON_KEY_TEMP]];
    humidity = [json objectForKey:OPEN_WEA_API_JSON_KEY_HUM];
    NSArray *array = [json objectForKey:OPEN_WEA_API_JSON_KEY_WEA];
    description = [[array objectAtIndex:0] objectForKey:OPEN_WEA_API_JSON_KEY_DES];
    
    [self setdateToDisplay:json];
    

    
    return self;
}
-(void)setdateToDisplay:(NSDictionary *)json
{
    NSTimeInterval timeZoneOffset = [[json objectForKey:OPEN_WEA_API_JSON_KEY_DATE] doubleValue];
    date = [NSDate dateWithTimeIntervalSince1970:timeZoneOffset];
    
    __autoreleasing NSDateFormatter *formatter = [[NSDateFormatter alloc] init];    // or
    NSLocale *locale = [NSLocale currentLocale];
    [formatter setLocale:locale];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    displayDate = [formatter stringFromDate:date];

}
-(void)setTemperature:(NSDictionary *)dict
{
    
    dayTemperature = [NSString stringWithFormat:@"%.0f°",[[dict objectForKey:OPEN_WEA_API_JSON_KEY_DAY]doubleValue]];
    eveTemperature = [NSString stringWithFormat:@"%.0f°",[[dict objectForKey:OPEN_WEA_API_JSON_KEY_EVE]doubleValue]];
    maxTemperature = [NSString stringWithFormat:@"%.0f°",[[dict objectForKey:OPEN_WEA_API_JSON_KEY_MAX]doubleValue]];
    minTemperature = [NSString stringWithFormat:@"%.0f°",[[dict objectForKey:OPEN_WEA_API_JSON_KEY_MIN]doubleValue]];
    morTemperature = [NSString stringWithFormat:@"%.0f°",[[dict objectForKey:OPEN_WEA_API_JSON_KEY_MOR]doubleValue]];
    nightTemperature = [NSString stringWithFormat:@"%.0f°",[[dict objectForKey:OPEN_WEA_API_JSON_KEY_NIG]doubleValue]];
    

}
@end
