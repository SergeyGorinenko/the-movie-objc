//
//  TMMovieGalleryInteractor.m
//  TheMovieKit
//
//  Created by Serhii Horinenko on 25.04.2024.
//

#import "TMMovieGalleryInteractor.h"

@interface TMMovieGalleryInteractor ()

@property (nonatomic) NSString *baseImageUrl;
@property (nonatomic) NSArray <NSString *>*imageSizes;

@property (nonatomic) NSInteger totalPages;
@property (nonatomic) NSInteger totalResults;
@property (nonatomic) NSInteger currPage;

@end


@implementation TMMovieGalleryInteractor

- (NSString *)basePosterUrl {
    return [NSString stringWithFormat:@"%@%@", self.baseImageUrl, self.imageSizes[self.imageSizes.count / 2]];
}

- (void)loadPage:(NSInteger)page completion:(void (^)(NSArray <TMMovieModel *>*movies, NSError *error))completion {
    [self getTopRatedMovies:page completion:completion];
}

- (void)getTopRatedMovies:(NSInteger)page completion:(void (^)(NSArray <TMMovieModel *>*movies, NSError *error))completion {
    __weak typeof(self) weakSelf = self;
    [TMGetConfigurationAPI.new getConfiguration:^(NSDictionary * _Nonnull configurationRep, NSError * _Nonnull error) {
        if (error) {
            completion(nil, error);
        } else {
            [weakSelf updateConfiguration:configurationRep];

            [TMGetTopRatedMoviesAPI.new getTopRatedMovies:page completion:^(NSDictionary * _Nonnull representation, NSError * _Nonnull error) {
                if (error) {
                    completion(nil, error);
                } else {
                    [weakSelf updatePageInfo:representation];
                    NSArray <TMMovieModel *>*resultMovies = [weakSelf parseMovies:representation basePosterUrl:weakSelf.basePosterUrl];
                    completion(resultMovies, nil);
                }
            }];
        }
    }];
}

- (void)updateConfiguration:(NSDictionary *)representation {
    if ([representation isKindOfClass:NSDictionary.class]) {
        
        NSDictionary *imagesRep = [representation objectForKey:@"images"];
        if ([imagesRep isKindOfClass:NSDictionary.class]) {
            
            NSString *baseImageUrl = [imagesRep valueForKey:@"base_url"];
            if ([baseImageUrl isKindOfClass:NSString.class]) {
                self.baseImageUrl = baseImageUrl;
            }
            
            NSArray <NSString *>*imageSizes = [imagesRep objectForKey:@"poster_sizes"];
            if ([imageSizes isKindOfClass:NSArray.class] && 0 < imageSizes.count) {
                self.imageSizes = imageSizes;
            }
        }
    }
}

- (void)updatePageInfo:(NSDictionary *)representation {
    if ([representation isKindOfClass:NSDictionary.class]) {
        id object = [representation valueForKey:@"total_pages"];
        if ([object isKindOfClass:NSNumber.class])
        {
            self.totalPages = [object integerValue];
        }
        
        object = [representation valueForKey:@"total_results"];
        if ([object isKindOfClass:NSNumber.class])
        {
            self.totalResults = [object integerValue];
        }

        object = [representation valueForKey:@"page"];
        if ([object isKindOfClass:NSNumber.class])
        {
            self.currPage = [object integerValue];
        }
    }
}

- (NSArray <TMMovieModel *>*)parseMovies:(NSDictionary *)representation basePosterUrl:(NSString *)basePosterUrl {
    NSMutableArray <TMMovieModel *>*resultMovies = [@[] mutableCopy];
    
    if ([representation isKindOfClass:NSDictionary.class]) {
        NSArray <NSDictionary *>*moviesRep = [representation objectForKey:@"results"];
        if ([moviesRep isKindOfClass:NSArray.class] && moviesRep.count > 0) {
            [moviesRep enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull movieRep, NSUInteger idx, BOOL * _Nonnull stop) {
                TMMovieModel *model = [TMMovieModel modelWithDictionary:movieRep];
                model.posterPath = [NSString stringWithFormat:@"%@%@", basePosterUrl, model.posterPath];
                [resultMovies addObject:model];
            }];
        }
    }

    return  [resultMovies copy];
}

@end


// MARK: - TMMovieGalleryInteractorProtocol

@implementation TMMovieGalleryInteractor (TMMovieGalleryInteractorProtocol)

- (void)loadFirstPage:(void (^)(NSArray <TMMovieModel *>*movies, NSError *error))completion {
    [self getTopRatedMovies:1 completion:completion];
}

- (void)loadNextPage:(void (^)(NSArray <TMMovieModel *>*movies, NSError *error))completion {
    [self getTopRatedMovies:self.currPage + 1 completion:completion];
}

@end
