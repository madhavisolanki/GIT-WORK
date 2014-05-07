

#import <Foundation/Foundation.h>

@interface CityData : NSObject

@property(nonatomic,strong)NSDate *date;
@property(nonatomic, strong)NSString *cityName;
@property(nonatomic, strong) NSString* dayTemperature;
@property(nonatomic, strong) NSString* minTemperature;
@property(nonatomic, strong) NSString* maxTemperature;
@property(nonatomic, strong) NSString* nightTemperature;
@property(nonatomic, strong) NSString* morTemperature;
@property(nonatomic, strong) NSString* eveTemperature;
@property(nonatomic, strong) NSString* pressure;
@property(nonatomic, strong) NSString* humidity;
@property(nonatomic, strong) NSString *averageTemp;
@property(nonatomic, strong) NSString *displayDate;

@property(nonatomic, strong)NSString *description;

- (id)initWithJSON: (NSDictionary *)json;

@end
