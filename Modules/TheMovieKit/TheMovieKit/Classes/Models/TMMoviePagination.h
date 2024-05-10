//
//  TMMoviePagination.h
//  TheMovieKit
//
//  Created by Serhii Horinenko on 09.05.2024.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TMMoviePagination : NSObject

/** The total number of pages in the response to the request. */
@property (nonatomic) NSInteger totalPages;

/** The total number of movies in the response to the request. */
@property (nonatomic) NSInteger totalResults;

/** Page number of the list of movies received in response to the request. */
@property (nonatomic) NSInteger currPage;

/**
 An instance initialization function that takes data from a dictionary passed as a parameter.
 
 @param representation Dictionary that contains init values for properties.
 @return An instance of the class.
 */
+ (instancetype)paginationWithDictionary:(NSDictionary *)representation;

/** Use paginationWithDictionary instead */
- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
