//
//  TMGetConfigurationAPI.m
//  TheMovieAPI
//
//  Created by Serhii Horinenko on 24.04.2024.
//

#import "TMGetConfigurationAPI.h"
#import "NSError+TheMovieAPI.h"

@implementation TMGetConfigurationAPI

- (NSURL *)apiURL {
    NSString *urlString = [NSString stringWithFormat:@"%@/configuration?api_key=%@", API_ENDPOINT, THEMOVIEDB_API_KEY];
    return [NSURL URLWithString:urlString];
}


- (void)getConfiguration:(void (^)(NSDictionary *configurationRep, NSError *error))completion {

    NSURLSession *session = [NSURLSession sharedSession];

    // Create an NSURLSessionDataTask object with a URL request
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:self.apiURL completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
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
