//
//  NSError+TheMovieAPI.h
//  TheMovieAPI
//
//  Created by Serhii Horinenko on 25.04.2024.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

extern NSString *const TMServerErrorDomain;

@interface NSError (TheMovieAPI)

+ (instancetype)errorWithDictionary:(NSDictionary *)errorRep;

@end

NS_ASSUME_NONNULL_END
