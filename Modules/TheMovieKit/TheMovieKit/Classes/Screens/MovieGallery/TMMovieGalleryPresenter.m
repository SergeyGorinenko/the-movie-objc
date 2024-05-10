//
//  TMMovieGalleryPresenter.m
//  TheMovieKit
//
//  Created by Serhii Horinenko on 25.04.2024.
//

#import "TMMovieGalleryPresenter.h"

/** A date formatter used to convert a movie's release date into a string for display in a cell. */
static NSDateFormatter *kTMMovieGalleryPresenterDateFormatter_ = nil;


@interface TMMovieGalleryPresenter ()

/** An array of movies displayed by View */
@property (nonatomic) NSArray <MCMovieModel *>* movies;

@end


@implementation TMMovieGalleryPresenter

/** Returns date formatter used to convert a movie's release date into a string for display in a cell. */
+ (NSDateFormatter *)dateFormatter {
    if (nil == kTMMovieGalleryPresenterDateFormatter_) {
        NSDateFormatter *dateFormatter = [NSDateFormatter new];
        dateFormatter.locale = [NSLocale localeWithLocaleIdentifier:@"en_US"];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        kTMMovieGalleryPresenterDateFormatter_ = dateFormatter;
    }
    return kTMMovieGalleryPresenterDateFormatter_;
}

/** This method causes the View component to update the data displayed in it. */
- (void)reloadView {
    [self.view reloadData];
}

/** Refreshes data loaded from the server. */
- (void)loadFirstPage {
    self.movies = nil;
    __weak typeof(self) weakSelf = self;
    [self.interactor loadFirstPage:^(NSArray * _Nonnull movies, NSError * _Nonnull error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.view endTopRefreshing];
            if (error) {
                [weakSelf.router presentError:error];
            } else {
                weakSelf.movies = movies;
                [weakSelf reloadView];
            }
        });
    }];
}

/** Loads another page of movies. */
- (void)loadNextPage {
    __weak typeof(self) weakSelf = self;
    [self.interactor loadNextPage:^(NSArray * _Nonnull movies, NSError * _Nonnull error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.view endBottomRefreshing];
            if (error) {
                [weakSelf.router presentError:error];
            } else {
                weakSelf.movies = [weakSelf.movies arrayByAddingObjectsFromArray:movies];
                [weakSelf reloadView];
            }
        });
    }];
}

@end


// MARK: - TMMovieGalleryViewDelegate

@implementation TMMovieGalleryPresenter (TMMovieGalleryViewDelegate)

- (void)configureView {
    [self.view beginTopRefreshing];
    [self loadFirstPage];
}

- (NSInteger)numberOfSections {
    return  1;
}

- (NSInteger)numberOfItemsInSection:(NSInteger)section {
    return self.movies.count;
}

- (void)configure:(UICollectionViewCell<TMMovieGalleryCellProtocol> *)cell indexPath:(nonnull NSIndexPath *)indexPath {
    NSArray <MCMovieModel *>* movies = self.movies;
    if (indexPath.row < movies.count) {
        MCMovieModel *movie = self.movies[indexPath.row];
        [cell setTitle:movie.title];
        [cell setRelease:[TMMovieGalleryPresenter.dateFormatter stringFromDate:movie.releaseDate]];
        [cell setRating:[NSString stringWithFormat:@"%0.1f", movie.voteAverage]];
        if (movie.posterPath != nil) {
            [cell setRemotePath:movie.posterPath];
        }
    }
}

- (void)beganTopRefreshing {
    [self loadFirstPage];
}

- (void)beganBottomRefreshing {
    [self loadNextPage];
}

@end
