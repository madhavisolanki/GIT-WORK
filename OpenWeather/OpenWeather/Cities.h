

#import <Foundation/Foundation.h>
#import "City.h"

@interface Cities : NSObject
@property(nonatomic,strong)NSMutableDictionary *cities;

+ (Cities *)sharedInstance;

@end
