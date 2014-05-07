

#import <Foundation/Foundation.h>

@interface CityResult : NSObject

@property(nonatomic,strong)NSString *cityName;

- (id)initWithJSON: (NSDictionary *)json;

@end
