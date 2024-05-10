//
//  MCMovieModel.h
//  TheMovieAPI
//
//  Created by Serhii Horinenko on 25.04.2024.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MCMovieModel : NSObject

/** Defines level of popularity of the movie. */
@property (nonatomic, readonly) CGFloat popularity;

/** Indicates the movie's audience rating. */
@property (nonatomic, readonly) CGFloat voteAverage;

/** Stands for the movie's release date. */
@property (nonatomic, readonly) NSDate *releaseDate;

/** Stands for the movie's backdrop path. */
@property (nonatomic, readonly) NSString *backdropPath;

/** Indicates the movie's original language. */
@property (nonatomic, readonly) NSString *originalLanguage;

/** Indicates whether the film is suitable for children. */
@property (nonatomic, readonly) BOOL adult;

/** Movie's ID in database. */
@property (nonatomic, readonly) NSInteger uid;

/** Original title of the movie. */
@property (nonatomic, readonly) NSString *originalTitle;

/** Original title of the movie. */
@property (nonatomic, readonly) NSString *title;

/** Ids of the genres of the movie. */
@property (nonatomic, readonly) NSArray <NSNumber *>*genreIds;

/** Total number of votes. */
@property (nonatomic, readonly) NSInteger voteCount;

/** Indicates if the movie has video. */
@property (nonatomic, readonly) BOOL video;

/** Movie's overview. */
@property (nonatomic, readonly) NSString *overview;

/** Poster path of the movie. */
@property (nonatomic) NSString *posterPath;

/**
 An instance initialization function that takes data from the dictionary passed as a parameter.
 
 @param representation Dictionary that contains values for properties.
 @return An instance of the class.
 */
+ (instancetype)modelWithDictionary:(NSDictionary *)representation;

@end

NS_ASSUME_NONNULL_END
