//
//  TMMovieList.h
//  TheMovieKit
//
//  Created by Serhii Horinenko on 09.05.2024.
//

#import <Foundation/Foundation.h>
#import <TheMovieCore/TheMovieCore.h>

NS_ASSUME_NONNULL_BEGIN

@interface TMMovieList : NSObject

/**
 A class method that parses the dictionary and creates a list of movies initialized with values from it.
 
 @param representation Dictionary that contains init values for the list of movies.
 @return A list of movies.
 */
+ (NSArray <MCMovieModel *>*)movies:(NSDictionary *)representation basePosterUrl:(NSString *)basePosterUrl;

/** Use movies: class method instead */
- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
