//
//  TMMovieGalleryRouter.h
//  TheMovieKit
//
//  Created by Serhii Horinenko on 25.04.2024.
//

#import <UIKit/UIKit.h>
#import "TMMovieGalleryProtocols.h"

NS_ASSUME_NONNULL_BEGIN

typedef void (^TMMovieGalleryRouterCompletion)(id result, NSError *error);


@interface TMMovieGalleryRouter : NSObject

/** Router keeps weak reference to View component of VIPER module */
@property (weak, nonatomic) UIViewController *viewController;

/** Normally this closure is run by Presenter whenever it needs module's owner (parent View) to handle some kind of event or error. */
@property (nonatomic) TMMovieGalleryRouterCompletion completion;


@end


/** TMMovieGalleryRouter extention to confirm TMMovieGalleryRouterProtocol protocol */
@interface TMMovieGalleryRouter (TMMovieGalleryRouterProtocol) <TMMovieGalleryRouterProtocol>
@end

NS_ASSUME_NONNULL_END
