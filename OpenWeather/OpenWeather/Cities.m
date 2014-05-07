

#import "Cities.h"
@interface Cities ()
{
@private __strong Cities *_citiesData;
}

@end


#pragma mark - Class Variables

static Cities *_sharedInstance;


@implementation Cities
@synthesize cities;

+ (void)initialize
{
	static BOOL classInitialized = NO;
	
	// If this class has not been initialized then create the shared instance.
	if (classInitialized == NO)
	{
		_sharedInstance = [[Cities alloc]
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
#pragma mark - Public Methods

+ (Cities *)sharedInstance
{
	return _sharedInstance;
}

- (id)init
{
	// Abort if base initializer fails.
	if ((self = [super init]) == nil)
	{
		return nil;
	}
	cities = [[NSMutableDictionary alloc] init];
	return self;
}
@end
