//
//  NSError+TheMovieAPI.m
//  TheMovieAPI
//
//  Created by Serhii Horinenko on 25.04.2024.
//

#import "NSError+TheMovieAPI.h"

/** The Movie platform errors' domain name. */
NSString *const TMServerErrorDomain = @"org.themoviedb.api.error.network";

@implementation NSError (TheMovieAPI)

+ (instancetype)errorWithDictionary:(NSDictionary *)errorRep {
    NSNumber *status = [errorRep valueForKey:@"success"];
    if ([status isKindOfClass:NSNumber.class] && !status.boolValue) {

        NSString *errorMessage = errorRep[@"status_message"];
        NSNumber *errorCode = errorRep[@"status_code"];
        if ([errorMessage isKindOfClass:NSString.class] && [errorCode isKindOfClass:NSNumber.class]) {
            return [NSError errorWithDomain:TMServerErrorDomain code:errorCode.integerValue userInfo:@{NSLocalizedDescriptionKey : NSLocalizedString(errorMessage, nil)}];
        } else {
            return [NSError errorWithDomain:TMServerErrorDomain code:-1 userInfo:@{NSLocalizedDescriptionKey : NSLocalizedString(@"Undefined server error", nil)}];
        }
    }
    return nil;
}

@end
