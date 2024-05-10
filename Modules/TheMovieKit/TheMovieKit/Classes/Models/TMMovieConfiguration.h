//
//  TMMovieConfiguration.h
//  TheMovieKit
//
//  Created by Serhii Horinenko on 09.05.2024.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TMMovieConfiguration : NSObject

/** The base path for posters divided by size into different subfolders there. */
@property (nonatomic) NSString *baseImageUrl;

/** A list of available sizes for posters. */
@property (nonatomic) NSArray <NSString *>*imageSizes;

/**
 An instance initialization function that takes data from the dictionary passed as a parameter.
 
 @param representation Dictionary that contains values for properties.
 @return An instance of the class.
 */
+ (instancetype)configurationWithDictionary:(NSDictionary *)representation;

/** Use configurationWithDictionary instead */
- (instancetype)init NS_UNAVAILABLE;

/** URL path where all posters are located. */
- (NSString *)basePosterUrl;

@end

NS_ASSUME_NONNULL_END
