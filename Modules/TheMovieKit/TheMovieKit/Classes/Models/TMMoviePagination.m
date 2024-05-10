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

- (instancetype)initWithDictionary:(NSDictionary *)representation {
    if (nil != (self = [super init])) {
        [self updateWithDictionary:representation];
    }
    return self;
}

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
