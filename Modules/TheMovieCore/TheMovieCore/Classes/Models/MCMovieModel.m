//
//  MCMovieModel.m
//  TheMovieAPI
//
//  Created by Serhii Horinenko on 25.04.2024.
//

#import "MCMovieModel.h"

/** A date formatter used to convert a movie's release date from string into a date. */
static NSDateFormatter *kMCMovieModelIso8601CombinedFormatter_ = nil;


@interface MCMovieModel ()

@property (nonatomic) CGFloat popularity;
@property (nonatomic) CGFloat voteAverage;
@property (nonatomic) NSDate *releaseDate;
@property (nonatomic) NSString *backdropPath;
@property (nonatomic) NSString *originalLanguage;
@property (nonatomic) BOOL adult;
@property (nonatomic) NSInteger uid;
@property (nonatomic) NSString *originalTitle;
@property (nonatomic) NSString *title;
@property (nonatomic) NSArray <NSNumber *>*genreIds;
@property (nonatomic) NSInteger voteCount;
@property (nonatomic) BOOL video;
@property (nonatomic) NSString *overview;

@end


@implementation MCMovieModel

/** Returns date formatter used to convert a movie's release date from string into a date. */
+ (NSDateFormatter *)iso8601CombinedFormatter {
    if (nil == kMCMovieModelIso8601CombinedFormatter_) {
        NSDateFormatter *dateFormatter = [NSDateFormatter new];
        dateFormatter.locale = [NSLocale localeWithLocaleIdentifier:@"en_US"];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        kMCMovieModelIso8601CombinedFormatter_ = dateFormatter;
    }
    return kMCMovieModelIso8601CombinedFormatter_;
}

+ (instancetype)modelWithDictionary:(NSDictionary *)representation {
    return [[MCMovieModel alloc] initWithDictionary:representation];
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
        id object = [representation valueForKey:@"popularity"];
        if ([object isKindOfClass:NSNumber.class]) {
            self.popularity = [object floatValue];
        }

        object = [representation valueForKey:@"vote_average"];
        if ([object isKindOfClass:NSNumber.class]) {
            self.voteAverage = [object floatValue];
        }

        object = [representation valueForKey:@"release_date"];
        if ([object isKindOfClass:NSString.class]) {
            self.releaseDate = [MCMovieModel.iso8601CombinedFormatter dateFromString:object];
        }

        object = [representation valueForKey:@"backdrop_path"];
        if ([object isKindOfClass:NSString.class]) {
            self.backdropPath = object;
        }

        object = [representation valueForKey:@"poster_path"];
        if ([object isKindOfClass:NSString.class]) {
            self.posterPath = object;
        }

        object = [representation valueForKey:@"original_language"];
        if ([object isKindOfClass:NSString.class]) {
            self.originalLanguage = object;
        }
        
        object = [representation valueForKey:@"adult"];
        if ([object isKindOfClass:NSNumber.class]) {
            self.adult = [object boolValue];
        }

        object = [representation valueForKey:@"id"];
        if ([object isKindOfClass:NSNumber.class]) {
            self.uid = [object integerValue];
        }

        object = [representation valueForKey:@"original_title"];
        if ([object isKindOfClass:NSString.class]) {
            self.originalTitle = object;
        }
        
        object = [representation valueForKey:@"title"];
        if ([object isKindOfClass:NSString.class]) {
            self.title = object;
        }
        
        NSArray <NSNumber *>*genreIds = [representation objectForKey:@"genre_ids"];
        if ([genreIds isKindOfClass:NSArray.class] && 0 < genreIds.count) {
            self.genreIds = genreIds;
        }

        object = [representation valueForKey:@"vote_count"];
        if ([object isKindOfClass:NSNumber.class]) {
            self.voteCount = [object integerValue];
        }

        object = [representation valueForKey:@"video"];
        if ([object isKindOfClass:NSNumber.class]) {
            self.video = [object boolValue];
        }

        object = [representation valueForKey:@"overview"];
        if ([object isKindOfClass:NSString.class]) {
            self.overview = object;
        }
    }
}

@end
