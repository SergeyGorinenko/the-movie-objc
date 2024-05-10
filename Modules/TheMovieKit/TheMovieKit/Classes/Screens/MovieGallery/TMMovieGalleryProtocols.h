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

/** Protocol that movie gallery cell must confirm to */
@protocol TMMovieGalleryCellProtocol

- (void)setTitle:(NSString *)title;
- (void)setRelease:(NSString *)release;
- (void)setRating:(NSString *)rating;
- (void)setRemotePath:(NSString *)remotePath;

@end


// MARK: - View Protocol

/** Protocol that View component of VIPER module must confirm to */
@protocol TMMovieGalleryViewProtocol

- (void)reloadData;
- (void)beginTopRefreshing;
- (void)endTopRefreshing;
- (void)beginBottmRefreshing;
- (void)endBottomRefreshing;

@end


// MARK: - View Delegate

/** Protocol that Presenter component of VIPER module must confirm to, to handle events coming from the View */
@protocol TMMovieGalleryViewDelegate

- (void)configureView;
- (NSInteger)numberOfSections;
- (NSInteger)numberOfItemsInSection:(NSInteger)section;
- (void)configure:(UICollectionViewCell<TMMovieGalleryCellProtocol> *)cell indexPath:(nonnull NSIndexPath *)indexPath;
- (void)beganTopRefreshing;
- (void)beganBottomRefreshing;

@end


// MARK: - Interactor Protocol

/** Protocol that Interactor component of VIPER module must confirm to, to handle events coming from the Presenter */
@protocol TMMovieGalleryInteractorProtocol

- (void)loadFirstPage:(void (^)(NSArray <MCMovieModel *>*movies, NSError *error))completion;
- (void)loadNextPage:(void (^)(NSArray <MCMovieModel *>*movies, NSError *error))completion;

@end


// MARK: - Router Protocol

/** Protocol that Router component of VIPER module must confirm to, to handle events coming from the Presenter */
@protocol TMMovieGalleryRouterProtocol

- (void)presentError:(NSError *)error;

@end
    
NS_ASSUME_NONNULL_END
