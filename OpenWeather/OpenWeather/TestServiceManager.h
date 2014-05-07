

#import <Foundation/Foundation.h>
#import "TestServiceResult.h"
#import "City.h"

typedef void (^TestServiceClientCompletion)		( TestServiceResult *result, NSArray *cities);
typedef void (^TestServiceClientWeatherDetailsCompletion)		( TestServiceResult *result, City *city);

typedef enum
{
    PTSignInFailed = 0,
    PTSignInLoading = 1,
    PTSignInSuccess = 2
} PTSignInState;

@interface TestServiceManager : NSObject
#pragma mark - Static Methods

+ (TestServiceManager *)sharedInstance;
+ (void)initialize;


#pragma mark - Instance Methods

- (void)freeze;
- (void)unfreeze;

- (void)getDataWithURL:(NSString *)uri
completion:(TestServiceClientCompletion)completion;

- (void)getDataWithCityName:(NSString *)city completion:(TestServiceClientWeatherDetailsCompletion)completion;

@end
