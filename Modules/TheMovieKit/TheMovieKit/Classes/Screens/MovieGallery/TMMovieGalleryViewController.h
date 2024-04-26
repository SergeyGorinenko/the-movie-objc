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

@property (nonatomic) id<TMMovieGalleryViewDelegate> presenter;

@end


@interface TMMovieGalleryViewController (TMMovieGalleryViewProtocol) <TMMovieGalleryViewProtocol>
@end

NS_ASSUME_NONNULL_END
