

#import <Foundation/Foundation.h>
#import "DBServiceClient.h"
#import "TestServiceResult.h"
#import "City.h"

@interface TestServiceClient : DBServiceClient

typedef void (^TestServiceClientCompletion)		( TestServiceResult *result, NSArray *cities);

typedef void (^TestServiceClientWeatherDetailsCompletion)		( TestServiceResult *result, City *city);


- (NSOperation *)getDataWithURL:(NSString *)uri completion:(TestServiceClientCompletion)completion;
- (NSOperation *)getDataWithCityName:(NSString *)city completion:(TestServiceClientWeatherDetailsCompletion)completion;

@end
