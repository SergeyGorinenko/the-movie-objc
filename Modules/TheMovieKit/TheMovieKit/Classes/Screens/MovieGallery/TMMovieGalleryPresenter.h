//
//  TMMovieGalleryPresenter.h
//  TheMovieKit
//
//  Created by Serhii Horinenko on 25.04.2024.
//

#import <Foundation/Foundation.h>
#import <TheMovieCore/TheMovieCore.h>
#import "TMMovieGalleryProtocols.h"

NS_ASSUME_NONNULL_BEGIN

@interface TMMovieGalleryPresenter : NSObject

/** Presenter keeps weak reference to View component of VIPER module */
@property (weak, nonatomic) id<TMMovieGalleryViewProtocol> view;

/** Presenter keeps strong reference to Interactor component of VIPER module */
@property (nonatomic) id<TMMovieGalleryInteractorProtocol> interactor;

/** Presenter keeps strong reference to Router component of VIPER module */
@property (nonatomic) id<TMMovieGalleryRouterProtocol> router;

@end


/** TMMovieGalleryPresenter extention to confirm TMMovieGalleryViewDelegate protocol */
@interface TMMovieGalleryPresenter (TMMovieGalleryViewDelegate) <TMMovieGalleryViewDelegate>
@end

NS_ASSUME_NONNULL_END
