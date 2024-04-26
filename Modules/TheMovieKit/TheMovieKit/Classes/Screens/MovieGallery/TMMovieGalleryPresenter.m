//
//  TMMovieGalleryPresenter.m
//  TheMovieKit
//
//  Created by Serhii Horinenko on 25.04.2024.
//

#import "TMMovieGalleryPresenter.h"

static NSDateFormatter *kTMMovieGalleryPresenterDateFormatter_ = nil;


@interface TMMovieGalleryPresenter ()

@property (nonatomic) NSArray <TMMovieModel *>* movies;

@end


@implementation TMMovieGalleryPresenter

+ (NSDateFormatter *)dateFormatter {
    if (nil == kTMMovieGalleryPresenterDateFormatter_) {
        NSDateFormatter *dateFormatter = [NSDateFormatter new];
        dateFormatter.locale = [NSLocale localeWithLocaleIdentifier:@"en_US"];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        kTMMovieGalleryPresenterDateFormatter_ = dateFormatter;
    }
    return kTMMovieGalleryPresenterDateFormatter_;
}

- (void)reloadView {
    [self.view reloadData];
}

@end


// MARK: - TMMovieGalleryViewDelegate

@implementation TMMovieGalleryPresenter (TMMovieGalleryViewDelegate)

- (void)configureView {
    __weak typeof(self) weakSelf = self;
    [self.interactor loadFirstPage:^(NSArray * _Nonnull movies, NSError * _Nonnull error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (error) {
                [weakSelf.router presentError:error];
            } else {
                weakSelf.movies = movies;
                [weakSelf reloadView];
            }
        });
    }];
}

- (NSInteger)numberOfSections {
    return  1;
}

- (NSInteger)numberOfItemsInSection:(NSInteger)section {
    return self.movies.count;
}

- (void)configure:(UICollectionViewCell<TMMovieGalleryCellProtocol> *)cell indexPath:(nonnull NSIndexPath *)indexPath {
    NSArray <TMMovieModel *>* movies = self.movies;
    if (indexPath.row < movies.count) {
        TMMovieModel *movie = self.movies[indexPath.row];
        [cell setTitle:movie.title];
        [cell setRelease:[TMMovieGalleryPresenter.dateFormatter stringFromDate:movie.releaseDate]];
        [cell setRating:[NSString stringWithFormat:@"%0.1f", movie.voteAverage]];
    }
}

@end
