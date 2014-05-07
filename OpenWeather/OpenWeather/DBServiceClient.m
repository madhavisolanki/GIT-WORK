

#import "DBServiceClient.h"

@implementation DBServiceClient

#pragma mark -
#pragma mark Constructors

- (id)init
{
    if ((self = [super init]) == nil)
	{
		return nil;
	}
	
	// Return initialized instance.
	return self;

}

- (DBServiceOperation *)beginRequestWithURL: (NSString *)uri
                                     method: (DBServiceMethod)method
                                    headers: (NSDictionary *)headers
                                      field:(DBServiceClientFieldCode)field
                                 parameters: (NSDictionary *)parameters
                                       body: (NSString *)body
                                     format: (DBServiceFormat)format
                                  transform: (id (^)(NSHTTPURLResponse *response, id data))transform
                                 completion: (void (^)(NSHTTPURLResponse *response,NSString *responseString, id data))completion
                                    context: (id)context;

{
    
    
    DBServiceOperation *serviceOperation = [[DBServiceOperation alloc] init];
    
    NSString *stringURL = [NSString stringWithFormat:@"%@%@",uri,[self getString:parameters]];
    
    NSURL *datasourceURL = [NSURL URLWithString:[self urlEncodeWithString:stringURL]];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:datasourceURL];
    serviceOperation.request = request;
    
    [self.requestQueue addOperationWithBlock: ^ {
        
        NSHTTPURLResponse* urlResponse = nil;
		NSError *error = [[NSError alloc] init];
        NSData *data = [NSURLConnection sendSynchronousRequest:serviceOperation.request
                                             returningResponse:&urlResponse
                                                         error:&error];
        
        NSString *response = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        completion(urlResponse,response, data);
        
        
    }];
    
    return serviceOperation;
}

-(NSString*)getString:(NSDictionary *)dict
{
    __autoreleasing NSMutableString *mutableString = [[NSMutableString alloc] init];
    
    for (NSString *string in [dict allKeys])
    {
        NSString *result = [NSString stringWithFormat:@"%@=%@&",string,[dict objectForKey:string]];
        result = [result stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [mutableString appendString:result];
    }
    return mutableString;
}


- (NSString *)urlEncodeWithString: (NSString*)string
{
    CFStringRef urlString = CFURLCreateStringByAddingPercentEscapes(
                                                                    NULL,
                                                                    (CFStringRef)string,
                                                                    NULL,
                                                                    (CFStringRef)@" ",
                                                                    kCFStringEncodingUTF8 );
    return (NSString *)CFBridgingRelease(urlString);
}











@end
