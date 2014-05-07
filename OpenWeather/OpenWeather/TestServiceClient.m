

#import "TestServiceClient.h"
#import "CityResult.h"
#import "CityData.h"
#import "City.h"
#import "OpenWeatherDefines.h"

@implementation TestServiceClient
+ (void)initialize
{
	static dispatch_once_t pred = 0;
    __strong static id _sharedObject = nil;
    dispatch_once(&pred, ^{
        _sharedObject = [[self alloc] init];
    });

}

- (id)init
{
	// Abort if base initializer fails.
	if ((self = [super init]) == nil)
	{
		return nil;
	}
	
	// Initialize instance variables.
    if (!self.requestQueue)
    {
        self.requestQueue = [[NSOperationQueue alloc] init];
    }
	self.requestQueue.maxConcurrentOperationCount = NSOperationQueueDefaultMaxConcurrentOperationCount;
	self.requestTimeout = RequestTimeout;
    
    
    
	// Return initialized instance.
	return self;
}

- (NSOperation *)getDataWithCityName:(NSString *)city completion:(TestServiceClientWeatherDetailsCompletion)completion;
{
    // Initialize parameters.
	NSMutableDictionary *parameters = [[NSMutableDictionary alloc]
                                       init];
    [parameters setValue:GOOGLE_API_KEY forKey:GOOGLE_API_PARA_APPID];
    [parameters setValue:GOOGLE_API_PARA_COUNT_VALUE forKey:GOOGLE_API_PARA_COUNT];
    [parameters setValue:city forKey: GOOGLE_API_CITY];
    [parameters setValue:GOOGLE_API_PARA_UNIT_VALUE forKey: GOOGLE_API_PARA_UNIT_KEY];
    
	return [self PT_beginGetRequestWithURL: GOOGLE_API_URL
                                parameters: parameters
                                    format: DBServiceFormatJson
                                     field:DBServiceClientTitleField
                                 transform: ^id(NSHTTPURLResponse *response, id data)
            {
                NSDictionary *json = data;
                CityResult *fundamentalData = [[CityResult alloc]
                                               initWithJSON: json];
                return fundamentalData;
            }
                                completion: ^(NSHTTPURLResponse *response,  NSString *responseString, id data)
            {
                TestServiceResult *value = [TestServiceResult resultWithStatusCode: response.statusCode];
                if (data) {
                    NSArray *arrayData = [[NSJSONSerialization JSONObjectWithData:data options:0 error:nil] objectForKey:GOOGLE_API_JSON_LIST];
                    City *objCity = [[City alloc]initWithArrayCityData:arrayData setCityName:city];
                    completion(value, objCity);
                }
          
            }];
}


- (NSOperation *)getDataWithURL:(NSString *)uri completion:(TestServiceClientCompletion)completion
{
	NSMutableDictionary *parameters = [[NSMutableDictionary alloc]
                                       init];
	[parameters setValue:OPEN_WEA_API_KEY_VALUE forKey: OPEN_WEA_API_KEY];
	[parameters setValue:uri forKey: OPEN_WEA_API_INPUT_KEY];
	[parameters setValue:OPEN_WEA_API_SENSOR_VALUE forKey: OPEN_WEA_API_SENSOR_KEY];

    // Make the request.
	return [self PT_beginGetRequestWithURL:OPEN_WEA_API_URL
                                parameters: parameters
                                    format: DBServiceFormatJson
                                    field:DBServiceClientTitleField
                                 transform: ^id(NSHTTPURLResponse *response, id data)
            {
                NSDictionary *json = data;
                CityResult *fundamentalData = [[CityResult alloc]
                                                      initWithJSON: json];
                return fundamentalData;
            }
            completion: ^(NSHTTPURLResponse *response,  NSString *responseString, id data)
            {
                TestServiceResult *value = [TestServiceResult resultWithStatusCode: response.statusCode];
                if (data) {
                    NSArray *arrayData = [[NSJSONSerialization JSONObjectWithData:data options:0 error:nil] objectForKey:OPEN_WEA_API_JSON_KEY_PRE];
                    NSMutableArray *arrayCities = [[NSMutableArray alloc] init];
                    for (NSDictionary *dict in arrayData) {
                        CityResult *fundamentalData = [[CityResult alloc]
                                                       initWithJSON: dict];
                        [arrayCities addObject:fundamentalData];
                    }
                    completion(value, arrayCities);

                }
                
                
               

            }];
}


- (DBServiceOperation *)PT_beginGetRequestWithURL: (NSString *)url
                                       parameters: (NSMutableDictionary *)parameters
                                           format: (DBServiceFormat)format
                                            field:(DBServiceClientFieldCode)field
                                        transform: (id (^)(NSHTTPURLResponse *response, id data))transform
                                       completion: (void (^)(NSHTTPURLResponse *response,  NSString *responseString, id data))completion
{
	NSMutableDictionary *headers = [[NSMutableDictionary alloc]
                                    init];
	
	// Make the request.
	return [self beginRequestWithURL: url
                              method: DBServiceMethodGet
                             headers: headers
                               field:field
                          parameters: parameters
                                body: nil
                              format: format
                           transform: transform
                          completion: completion
                             context: nil];
}
@end
