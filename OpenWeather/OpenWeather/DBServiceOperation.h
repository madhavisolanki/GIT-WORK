

#import <Foundation/Foundation.h>

@interface DBServiceOperation : NSOperation

#pragma mark -
#pragma mark Properties

@property (nonatomic, strong) NSURLRequest *request;

@property (nonatomic, strong) id context;


@end
