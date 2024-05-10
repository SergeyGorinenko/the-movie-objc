//
//  TMMoviePagination.h
//  TheMovieKit
//
//  Created by Serhii Horinenko on 09.05.2024.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TMMoviePagination : NSObject

@property (nonatomic) NSInteger totalPages;
@property (nonatomic) NSInteger totalResults;
@property (nonatomic) NSInteger currPage;

+ (instancetype)paginationWithDictionary:(NSDictionary *)representation;
- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
