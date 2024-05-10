//
//  TMMovieConfiguration.m
//  TheMovieKit
//
//  Created by Serhii Horinenko on 09.05.2024.
//

#import "TMMovieConfiguration.h"

@implementation TMMovieConfiguration

+ (instancetype)configurationWithDictionary:(NSDictionary *)representation {
    return [[TMMovieConfiguration alloc] initWithDictionary:representation];
}

- (instancetype)initWithDictionary:(NSDictionary *)representation {
    if (nil != (self = [super init])) {
        [self updateWithDictionary:representation];
    }
    return self;
}

- (NSString *)basePosterUrl {
    return [NSString stringWithFormat:@"%@%@", self.baseImageUrl, self.imageSizes[self.imageSizes.count / 2]];
}

- (void)updateWithDictionary:(NSDictionary *)representation {
    if ([representation isKindOfClass:NSDictionary.class]) {
        
        NSDictionary *imagesRep = [representation objectForKey:@"images"];
        if ([imagesRep isKindOfClass:NSDictionary.class]) {
            
            NSString *baseImageUrl = [imagesRep valueForKey:@"base_url"];
            if ([baseImageUrl isKindOfClass:NSString.class]) {
                self.baseImageUrl = baseImageUrl;
            }
            
            NSArray <NSString *>*imageSizes = [imagesRep objectForKey:@"poster_sizes"];
            if ([imageSizes isKindOfClass:NSArray.class] && 0 < imageSizes.count) {
                self.imageSizes = imageSizes;
            }
        }
    }
}

@end
