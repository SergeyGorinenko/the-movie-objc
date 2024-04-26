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

@property (weak, nonatomic) id<TMMovieGalleryViewProtocol> view;
@property (nonatomic) id<TMMovieGalleryInteractorProtocol> interactor;
@property (nonatomic) id<TMMovieGalleryRouterProtocol> router;

@end


@interface TMMovieGalleryPresenter (TMMovieGalleryViewDelegate) <TMMovieGalleryViewDelegate>
@end

NS_ASSUME_NONNULL_END
