//
//  TMMovieGalleryProtocols.h
//  TheMovieKit
//
//  Created by Serhii Horinenko on 25.04.2024.
//

#import <UIKit/UIKit.h>
#import <TheMovieCore/TheMovieCore.h>

NS_ASSUME_NONNULL_BEGIN

// MARK: - TMMovieGalleryCellProtocol

@protocol TMMovieGalleryCellProtocol

- (void)setTitle:(NSString *)title;
- (void)setRelease:(NSString *)release;
- (void)setRating:(NSString *)rating;
- (void)setRemotePath:(NSString *)remotePath;

@end


// MARK: - View Protocol

@protocol TMMovieGalleryViewProtocol

- (void)reloadData;
- (void)beginTopRefreshing;
- (void)endTopRefreshing;
- (void)beginBottmRefreshing;
- (void)endBottomRefreshing;

@end


// MARK: - View Delegate

@protocol TMMovieGalleryViewDelegate

- (void)configureView;
- (NSInteger)numberOfSections;
- (NSInteger)numberOfItemsInSection:(NSInteger)section;
- (void)configure:(UICollectionViewCell<TMMovieGalleryCellProtocol> *)cell indexPath:(nonnull NSIndexPath *)indexPath;
- (void)beganTopRefreshing;
- (void)beganBottomRefreshing;

@end


// MARK: - Interactor Protocol

@protocol TMMovieGalleryInteractorProtocol

- (void)loadFirstPage:(void (^)(NSArray <TMMovieModel *>*movies, NSError *error))completion;
- (void)loadNextPage:(void (^)(NSArray <TMMovieModel *>*movies, NSError *error))completion;

@end


// MARK: - Router Protocol

@protocol TMMovieGalleryRouterProtocol

- (void)presentError:(NSError *)error;

@end
    
NS_ASSUME_NONNULL_END
