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

/**
 Sets the cell title value.
 
 @param title String for the title value of the cell.
 */
- (void)setTitle:(NSString *)title;

/**
 Sets the cell release value.
 
 @param release a string for the release value of the cell.
 */
- (void)setRelease:(NSString *)release;

/**
 Sets the cell rating value.
 
 @param rating A string for the rating value of the cell.
 */
- (void)setRating:(NSString *)rating;

/**
 Sets the image path value for the cell.
 
 @param remotePath A string for the path value of the cell image.
 */
- (void)setRemotePath:(NSString *)remotePath;

@end


// MARK: - View Protocol

/** Protocol that View component of VIPER module must confirm to */
@protocol TMMovieGalleryViewProtocol

/** Must be called whenever View needs to be reloaded. */
- (void)reloadData;

/** Starts top refresh control animation. */
- (void)beginTopRefreshing;

/** Ends top refresh control animation. */
- (void)endTopRefreshing;

/** Starts bottom refresh control animation. */
- (void)beginBottmRefreshing;

/** Ends bottom refresh control animation. */
- (void)endBottomRefreshing;

@end


// MARK: - View Delegate

/** Protocol that Presenter component of VIPER module must confirm to, to handle events coming from the View */
@protocol TMMovieGalleryViewDelegate

/** Normally this method is run when View finishes loading (from viewDidLoad) */
- (void)configureView;

/** Number of sections in View's collection view. */
- (NSInteger)numberOfSections;

/**
 Number of movies in a specific section.
 
 @param section Number of the section for which the method returns the number of elements.
 */
- (NSInteger)numberOfItemsInSection:(NSInteger)section;

/**
 The method is called by View to set all the values of a cell located at a specific position.
 
 @param cell The cell whose data needs to be set.
 @param indexPath Index of the cell whose data needs to be set.
 */
- (void)configure:(UICollectionViewCell<TMMovieGalleryCellProtocol> *)cell indexPath:(nonnull NSIndexPath *)indexPath;

/** Normally call by View  whenever it starts refreshing its collection view. */
- (void)beganTopRefreshing;

/** Typically called by View whenever it needs to load another portion of movies to display. */
- (void)beganBottomRefreshing;

@end


// MARK: - Interactor Protocol

/** Protocol that Interactor component of VIPER module must confirm to, to handle events coming from the Presenter */
@protocol TMMovieGalleryInteractorProtocol

/**
 This function loads the first page of movies for the movie gallery. It also removes all the movie items loaded previously so it works as refreshing.
 
 @param completion A closure that is called when a list of movies is retrieved or an error occurs.
 */
- (void)loadFirstPage:(void (^)(NSArray <MCMovieModel *>*movies, NSError *error))completion;

/**
 This function loads the next movie page for the movie gallery. Interactor keeps track of the page it last loaded.
 
 @param completion A closure that is called when a list of movies is retrieved or an error occurs.
 */
- (void)loadNextPage:(void (^)(NSArray <MCMovieModel *>*movies, NSError *error))completion;

@end


// MARK: - Router Protocol

/** Protocol that Router component of VIPER module must confirm to, to handle events coming from the Presenter */
@protocol TMMovieGalleryRouterProtocol

/**
 This function presents an alert with the error message passed as a parameter..
 
 @param error The error that needs to be displayed to user.
 */
- (void)presentError:(NSError *)error;

@end
    
NS_ASSUME_NONNULL_END
