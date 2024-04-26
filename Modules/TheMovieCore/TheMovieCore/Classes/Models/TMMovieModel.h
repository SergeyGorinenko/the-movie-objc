//
//  TMMovieModel.h
//  TheMovieAPI
//
//  Created by Serhii Horinenko on 25.04.2024.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TMMovieModel : NSObject

@property (nonatomic, readonly) CGFloat popularity;
@property (nonatomic, readonly) CGFloat voteAverage;
@property (nonatomic, readonly) NSDate *releaseDate;
@property (nonatomic, readonly) NSString *backdropPath;
@property (nonatomic, readonly) NSString *originalLanguage;
@property (nonatomic, readonly) BOOL adult;
@property (nonatomic, readonly) NSInteger uid;
@property (nonatomic, readonly) NSString *originalTitle;
@property (nonatomic, readonly) NSString *title;
@property (nonatomic, readonly) NSArray <NSNumber *>*genreIds;
@property (nonatomic, readonly) NSInteger voteCount;
@property (nonatomic, readonly) BOOL video;
@property (nonatomic, readonly) NSString *overview;
@property (nonatomic) NSString *posterPath;

+ (instancetype)modelWithDictionary:(NSDictionary *)representation;

@end

NS_ASSUME_NONNULL_END
