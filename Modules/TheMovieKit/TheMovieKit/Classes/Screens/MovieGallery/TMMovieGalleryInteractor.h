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

- (instancetype)init NS_UNAVAILABLE;

/**
 Initialization function that takes data provider as a parameter.
 
 @param dataProvider A data provider that will be used to get movie items for the movie gallery.
 */
- (instancetype)init:(id<TMMovieDataProvider>)dataProvider;

@end


@interface TMMovieGalleryInteractor (TMMovieGalleryInteractorProtocol) <TMMovieGalleryInteractorProtocol>

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

NS_ASSUME_NONNULL_END
