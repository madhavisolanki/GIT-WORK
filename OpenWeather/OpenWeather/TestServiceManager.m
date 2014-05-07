
#import "TestServiceManager.h"
#import "TestServiceClient.h"
#import "TestServiceResult.h"
#pragma mark - Class Extension

@interface TestServiceManager ()
{
@private __strong TestServiceClient *_serviceClient;
}

@end
#pragma mark - Class Variables

static TestServiceManager *_sharedInstance;


@implementation TestServiceManager

+ (void)initialize
{
	static BOOL classInitialized = NO;
	
	// If this class has not been initialized then create the shared instance.
	if (classInitialized == NO)
	{
		_sharedInstance = [[TestServiceManager alloc]
                           init];
		
		classInitialized = YES;
	}
}

+ (id)allocWithZone: (NSZone *)zone
{
	// Because we are creating the shared instance in the +initialize method we
	// can check if it exists here to know if we should alloc an instance of the class.
	if (_sharedInstance == nil)
	{
		return [super allocWithZone: zone];
	}
	else
	{
	    return [self sharedInstance];
	}
}

- (id)init
{
	// Abort if base initializer fails.
	if ((self = [super init]) == nil)
	{
		return nil;
	}
	
	// Initialize instance variables.
    _serviceClient = [[TestServiceClient alloc]
                      init];
	
	// Return initialized instance.
	return self;
}


#pragma mark - Public Methods

+ (TestServiceManager *)sharedInstance
{
	return _sharedInstance;
}

- (void)freeze
{
    // Nil out current list ID being fetched, if any.
}

- (void)unfreeze
{
}

- (void)getDataWithURL:(NSString *)uri
                            completion: (TestServiceClientCompletion)completion
{
    [_serviceClient getDataWithURL:uri completion: ^(TestServiceResult *result, NSArray *cities)
     {
         completion(result, cities);

     }];
}

- (void)getDataWithCityName:(NSString *)city completion:(TestServiceClientWeatherDetailsCompletion)completion
{
    [_serviceClient getDataWithCityName:city completion: ^(TestServiceResult *result, City *city)
     {
         completion(result, city);
         
     }];
}



@end
