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

- (NSString *)basePosterUrl {
    return [NSString stringWithFormat:@"%@%@", self.baseImageUrl, self.imageSizes[self.imageSizes.count / 2]];
}

/**
 Parsing method that sets instance properties to appropriate values.
 
 @param representation Dictionary that contains init values for properties.
 */
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
