//
//  TMGetTopRatedMoviesAPI.h
//  TheMovieAPI
//
//  Created by Serhii Horinenko on 25.04.2024.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TMGetTopRatedMoviesAPI : NSObject

- (void)getTopRatedMovies:(NSInteger)page completion:(void (^)(NSDictionary *moviesRep, NSError *error))completion;

@end

NS_ASSUME_NONNULL_END
