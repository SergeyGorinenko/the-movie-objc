//
//  TMMovieDataProvider.h
//  TheMovieKit
//
//  Created by Serhii Horinenko on 09.05.2024.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol TMMovieDataProvider <NSObject>

- (void)getConfiguration:(void (^)(NSDictionary *configurationRep, NSError *error))completion;
- (void)getTopRatedMovies:(NSInteger)page completion:(void (^)(NSDictionary *moviesRep, NSError *error))completion;

@end

NS_ASSUME_NONNULL_END
