

#pragma mark Constants


#pragma mark - Enumerations


#pragma mark - Class Interface

@interface TestServiceResult : NSObject
{
}


#pragma mark - Properties

@property (nonatomic, readonly) BOOL success;
@property (nonatomic, readonly) NSInteger statusCode;
@property (nonatomic, readonly) NSString *error;


#pragma mark - Methods

+ (TestServiceResult *)resultWithError: (NSString *)error
	statusCode: (NSInteger)statusCode;
+ (TestServiceResult *)resultWithStatusCode: (NSInteger)statusCode;


@end