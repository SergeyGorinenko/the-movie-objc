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

/** A data provider that is used to get movie items for the movie gallery.  */
@property (nonatomic) id<TMMovieDataProvider> dataProvider;

/** Model that keeps data configuration information.  */
@property (nonatomic) TMMovieConfiguration *configuration;

/** Model responsible for tracking pagination related data.  */
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

/**
 This function loads a list of movies for a specific page.
 
 @param page number of the page for which this method requests a list of movies from the server.
 @param completion A closure that is called when a list of movies is retrieved or an error occurs.
 */
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
