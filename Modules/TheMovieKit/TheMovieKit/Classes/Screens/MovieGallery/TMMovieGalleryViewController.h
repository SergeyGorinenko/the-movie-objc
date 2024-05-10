//
//  TMMovieGalleryViewController.h
//  TheMovieKit
//
//  Created by Serhii Horinenko on 25.04.2024.
//

#import <UIKit/UIKit.h>
#import "TMMovieGalleryProtocols.h"

NS_ASSUME_NONNULL_BEGIN

@interface TMMovieGalleryViewController : UIViewController

/** View keeps strong reference to Presenter component of VIPER module */
@property (nonatomic) id<TMMovieGalleryViewDelegate> presenter;

@end


/** TMMovieGalleryViewController extention to confirm TMMovieGalleryViewProtocol protocol */
@interface TMMovieGalleryViewController (TMMovieGalleryViewProtocol) <TMMovieGalleryViewProtocol>
@end

NS_ASSUME_NONNULL_END
