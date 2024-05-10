//
//  TMMovieList.m
//  TheMovieKit
//
//  Created by Serhii Horinenko on 09.05.2024.
//

#import "TMMovieList.h"

@implementation TMMovieList

+ (NSArray <MCMovieModel *>*)movies:(NSDictionary *)representation basePosterUrl:(NSString *)basePosterUrl {
    NSMutableArray <MCMovieModel *>*resultMovies = [@[] mutableCopy];
    
    if ([representation isKindOfClass:NSDictionary.class]) {
        NSArray <NSDictionary *>*moviesRep = [representation objectForKey:@"results"];
        if ([moviesRep isKindOfClass:NSArray.class] && moviesRep.count > 0) {
            [moviesRep enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull movieRep, NSUInteger idx, BOOL * _Nonnull stop) {
                MCMovieModel *model = [MCMovieModel modelWithDictionary:movieRep];
                model.posterPath = [NSString stringWithFormat:@"%@%@", basePosterUrl, model.posterPath];
                [resultMovies addObject:model];
            }];
        }
    }

    return  [resultMovies copy];
}

@end
