

#ifndef DiffBot_DBServiceClientDefines_h
#define DiffBot_DBServiceClientDefines_h

#pragma mark Constants

#define RequestTimeout 30.0


#pragma mark -
#pragma mark Error Domain/Codes

extern NSString * const DBServiceClientErrorDomain;

typedef enum
{
    DBServiceClientAllocationError = 0,
    DBServiceClientInvalidFormatError = 1,
    DBServiceClientUnhandledFormatError = 2
    
} DBServiceClientErrorCode;




#pragma mark -
#pragma mark Enumerations

typedef enum
{
    DBServiceClientAllField = 0,
    DBServiceClientTitleField = 1,
    
} DBServiceClientFieldCode;



typedef enum
{
    DBServiceMethodGet,
    DBServiceMethodPost,
    DBServiceMethodPut,
    DBServiceMethodDelete
    
} DBServiceMethod;

enum
{
    DBServiceFormatRaw = 0,
    DBServiceFormatString = 1,
    DBServiceFormatFormEncoded = 2,
    DBServiceFormatJson = 3
    
};
typedef NSUInteger DBServiceFormat;

typedef enum
{
    DBServiceResultCancelled = -1,
    DBServiceResultFailed = 0,
    DBServiceResultSuccess = 1
    
} DBServiceResult;

#endif
