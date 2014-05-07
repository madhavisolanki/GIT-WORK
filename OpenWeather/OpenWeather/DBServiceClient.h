

#import <Foundation/Foundation.h>
#import "DBServiceOperation.h"
#import "DBServiceClientDefines.h"
@interface DBServiceClient : NSObject

#pragma mark -
#pragma mark Properties

@property (nonatomic, strong) NSOperationQueue *requestQueue;

@property (nonatomic, assign) NSTimeInterval requestTimeout;




#pragma mark -
#pragma mark Constructors

- (id)init;

#pragma mark -
#pragma mark Instance Methods

- (DBServiceOperation *)beginRequestWithURL: (NSString *)uri
                                     method: (DBServiceMethod)method
                                    headers: (NSDictionary *)headers
                                      field:(DBServiceClientFieldCode)field
                                 parameters: (NSDictionary *)parameters
                                       body: (NSString *)body
                                     format: (DBServiceFormat)format
                                  transform: (id (^)(NSHTTPURLResponse *response, id data))transform
                                 completion: (void (^)(NSHTTPURLResponse *response,  NSString *responseString, id data))completion
                                    context: (id)context;

@end
