//
//  TMMovieGalleryInteractor.m
//  TheMovieKit
//
//  Created by Serhii Horinenko on 25.04.2024.
//

#import "TMMovieGalleryInteractor.h"
#import "TMMovieConfiguration.h"
#import "TMMoviePagination.h"
#import "TMMovieList.h"

@interface TMMovieGalleryInteractor ()

@property (nonatomic) id<TMMovieDataProvider> dataProvider;
@property (nonatomic) TMMovieConfiguration *configuration;
@property (nonatomic) TMMoviePagination *pagination;

@end


@implementation TMMovieGalleryInteractor

- (instancetype)init:(id<TMMovieDataProvider>)dataProvider {
    self = [super init];
    if (self) {
        self.dataProvider = dataProvider;
    }
    return self;
}

- (void)getTopRatedMovies:(NSInteger)page completion:(void (^)(NSArray <MCMovieModel *>*movies, NSError *error))completion {
    
    __weak typeof(self) weakSelf = self;
    void (^getTopRatedMovies)(void) = ^{
        [weakSelf.dataProvider getTopRatedMovies:page completion:^(NSDictionary * _Nonnull representation, NSError * _Nonnull error) {
            if (error) {
                completion(nil, error);
            } else {
                weakSelf.pagination = [TMMoviePagination paginationWithDictionary:representation];

                NSArray <MCMovieModel *>*resultMovies = [TMMovieList movies:representation basePosterUrl:weakSelf.configuration.basePosterUrl];
                completion(resultMovies, nil);
            }
        }];
    };
    
    if (self.configuration == nil) {
        [self.dataProvider getConfiguration:^(NSDictionary * _Nonnull configurationRep, NSError * _Nonnull error) {
            if (error) {
                completion(nil, error);
            } else {
                weakSelf.configuration = [TMMovieConfiguration configurationWithDictionary:configurationRep];
                getTopRatedMovies();
            }
        }];
    } else {
        getTopRatedMovies();
    }
}

@end


// MARK: - TMMovieGalleryInteractorProtocol

@implementation TMMovieGalleryInteractor (TMMovieGalleryInteractorProtocol)

- (void)loadFirstPage:(void (^)(NSArray <MCMovieModel *>*movies, NSError *error))completion {
    self.configuration = nil;
    self.pagination = nil;
    [self getTopRatedMovies:1 completion:completion];
}

- (void)loadNextPage:(void (^)(NSArray <MCMovieModel *>*movies, NSError *error))completion {
    [self getTopRatedMovies:self.pagination.currPage + 1 completion:completion];
}

@end
