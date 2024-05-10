//
//  MAGetTopRatedMoviesAPI.h
//  TheMovieAPI
//
//  Created by Serhii Horinenko on 25.04.2024.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MAGetTopRatedMoviesAPI : NSObject

/**
 Loads movie's for a specified page number.
 
 @param page The page number for which movies will be received..
 @param completion A closure that is called when movies data is retrieved or an error occurs.
 */
- (void)getTopRatedMovies:(NSInteger)page completion:(void (^)(NSDictionary *moviesRep, NSError *error))completion;

@end

NS_ASSUME_NONNULL_END
