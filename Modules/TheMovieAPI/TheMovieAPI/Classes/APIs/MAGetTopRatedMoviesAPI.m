//
//  MAGetTopRatedMoviesAPI.m
//  TheMovieAPI
//
//  Created by Serhii Horinenko on 25.04.2024.
//

#import "MAGetTopRatedMoviesAPI.h"
#import "NSError+TheMovieAPI.h"

@implementation MAGetTopRatedMoviesAPI

/** Returns URL to get movie's for a specified page number. */
- (NSURL *)apiURL:(NSInteger)page {
    NSString *urlString = [NSString stringWithFormat:@"%@/movie/top_rated?api_key=%@&page=%@", API_ENDPOINT, THEMOVIEDB_API_KEY, @(page)];
    return [NSURL URLWithString:urlString];
}


- (void)getTopRatedMovies:(NSInteger)page completion:(void (^)(NSDictionary *moviesRep, NSError *error))completion {

    NSURLSession *session = [NSURLSession sharedSession];

    // Create an NSURLSessionDataTask object with a URL request
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:[self apiURL:page] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            completion(nil, error);
        } else {
            NSError *error = nil;
            NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];

            if (error) {
                completion(nil, error);
            } else {
                error = [NSError errorWithDictionary:jsonDict];
                if (error) {
                    completion(nil, error);
                } else {
                    completion(jsonDict, nil);
                }
            }
        }
    }];

    [dataTask resume];
}

@end
