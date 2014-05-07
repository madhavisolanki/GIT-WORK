#import "TestServiceResult.h"


#pragma mark Constants


#pragma mark - Class Extension

@interface TestServiceResult ()
{
	@private BOOL _success;
	@private NSInteger _statusCode;
	@private __strong NSString *_error;
}

- (id)initWithSuccess: (BOOL)success
	error: (NSString *)error
	statusCode: (NSInteger)statusCode;


@end


#pragma mark - Class Definition

@implementation TestServiceResult


#pragma mark - Properties

@synthesize success = _success;
@synthesize error = _error;
@synthesize statusCode = _statusCode;


#pragma mark - Constructors

- (id)initWithSuccess: (BOOL)success
	error: (NSString *)error
	statusCode: (NSInteger)statusCode
{
    // Abort if base constructor fails.
	if ((self = [super init]) == nil)
	{
		return nil;
	}

	_success = success;
	_error = error;
	_statusCode = statusCode;

    // Return initialized instance.
	return self;
}


#pragma mark - Public Methods

+ (TestServiceResult *)resultWithError: (NSString *)error
	statusCode: (NSInteger)statusCode
{
	return [[TestServiceResult alloc]
		initWithSuccess: NO 
		error: error 
		statusCode: statusCode];
}

+ (TestServiceResult *)resultWithStatusCode: (NSInteger)statusCode
{
	return [[TestServiceResult alloc]
		initWithSuccess: YES 
		error: nil 
		statusCode: statusCode];
}


@end