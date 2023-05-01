//
//  Utility.m
//  SampleApp
//

#import "Utility.h"

@implementation Utility

+(NSString *)saveResponseInString:(id)strResponse
{
    if (![strResponse isKindOfClass:[NSString class]])
    {
        if ([strResponse isKindOfClass:[NSArray class]])
        {
            NSArray *array = (NSArray *)strResponse;
            if (array.count > 0) {
                strResponse = [NSString stringWithFormat:@"%@",[strResponse objectAtIndex:0]];
                [self saveResponseInString:strResponse];
            } else {
                return @"";
            }
        }
        else
        {
            if([strResponse isKindOfClass:[NSNull class]])
            {
                return @"";
            }
            else
            {
                if ([strResponse respondsToSelector:@selector(stringValue)])
                {
                    strResponse = [strResponse stringValue];
                }
            }
        }
    }
    
    if([strResponse isKindOfClass:[NSNull class]])
    {
        return @"";
    }
    else if ([strResponse isEqualToString:@""] || strResponse == nil) {
        
        return @"";
    }
    return strResponse;
}

@end
