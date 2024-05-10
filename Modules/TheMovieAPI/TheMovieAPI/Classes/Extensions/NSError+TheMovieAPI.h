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

/**
 An instance initialization function that takes data from the dictionary passed as a parameter.
 
 @param errorRep Dictionary that contains values for properties.
 @return An instance of the NSError class.
 */
+ (instancetype)errorWithDictionary:(NSDictionary *)errorRep;

@end

NS_ASSUME_NONNULL_END
