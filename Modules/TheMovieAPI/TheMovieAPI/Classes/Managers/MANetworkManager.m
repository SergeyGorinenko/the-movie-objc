//
//  MANetworkManager.m
//  TheMovieAPI
//
//  Created by Serhii Horinenko on 09.05.2024.
//

#import "MANetworkManager.h"
#import "MAGetConfigurationAPI.h"
#import "MAGetTopRatedMoviesAPI.h"

@implementation MANetworkManager

- (void)getConfiguration:(void (^)(NSDictionary *configurationRep, NSError *error))completion {
    [MAGetConfigurationAPI.new getConfiguration:completion];
}

- (void)getTopRatedMovies:(NSInteger)page completion:(void (^)(NSDictionary *moviesRep, NSError *error))completion {
    [MAGetTopRatedMoviesAPI.new getTopRatedMovies:page completion:completion];
}

@end
