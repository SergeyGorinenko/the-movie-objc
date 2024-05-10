//
//  TMMoviePagination.m
//  TheMovieKit
//
//  Created by Serhii Horinenko on 09.05.2024.
//

#import "TMMoviePagination.h"

@implementation TMMoviePagination

+ (instancetype)paginationWithDictionary:(NSDictionary *)representation {
    return [[TMMoviePagination alloc] initWithDictionary:representation];
}

/**
 An instance initialization function that takes data from the dictionary passed as a parameter.
 
 @param representation Dictionary that contains init values for properties.
 @return An instance of the class.
 */
- (instancetype)initWithDictionary:(NSDictionary *)representation {
    if (nil != (self = [super init])) {
        [self updateWithDictionary:representation];
    }
    return self;
}

/**
 Parsing method that sets instance properties to appropriate values.
 
 @param representation Dictionary that contains init values for properties.
 */
- (void)updateWithDictionary:(NSDictionary *)representation {
    if ([representation isKindOfClass:NSDictionary.class]) {
        id object = [representation valueForKey:@"total_pages"];
        if ([object isKindOfClass:NSNumber.class])
        {
            self.totalPages = [object integerValue];
        }
        
        object = [representation valueForKey:@"total_results"];
        if ([object isKindOfClass:NSNumber.class])
        {
            self.totalResults = [object integerValue];
        }

        object = [representation valueForKey:@"page"];
        if ([object isKindOfClass:NSNumber.class])
        {
            self.currPage = [object integerValue];
        }
    }
}

@end
