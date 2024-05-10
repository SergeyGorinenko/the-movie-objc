//
//  TMMovieGalleryInteractor.h
//  TheMovieKit
//
//  Created by Serhii Horinenko on 25.04.2024.
//

#import <Foundation/Foundation.h>
#import <TheMovieCore/TheMovieCore.h>
#import <TheMovieAPI/TheMovieAPI.h>
#import "TMMovieGalleryProtocols.h"
#import "TMMovieDataProvider.h"

NS_ASSUME_NONNULL_BEGIN

@interface TMMovieGalleryInteractor : NSObject

/**
 An instance initialization function that takes data provider as a parameter.
 
 @param dataProvider A data provider that will be used to get movie items for the movie gallery.
 @return An instance of the class.
  */
- (instancetype)init:(id<TMMovieDataProvider>)dataProvider;

/** Use init: instead */
- (instancetype)init NS_UNAVAILABLE;

@end


/** TMMovieGalleryInteractor extention to confirm TMMovieGalleryInteractorProtocol protocol */
@interface TMMovieGalleryInteractor (TMMovieGalleryInteractorProtocol) <TMMovieGalleryInteractorProtocol>
@end

NS_ASSUME_NONNULL_END
