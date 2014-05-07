

#import <Foundation/Foundation.h>
@interface City : NSObject
@property(nonatomic,strong)NSMutableArray *arraycityData;
@property(nonatomic, strong)NSString *cityName;

- (id)initWithArrayCityData: (NSArray *)array setCityName:(NSString *)city;

@end
