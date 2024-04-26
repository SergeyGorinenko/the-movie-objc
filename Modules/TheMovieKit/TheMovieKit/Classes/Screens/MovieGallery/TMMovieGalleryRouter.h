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

@property (weak, nonatomic) UIViewController *viewController;
@property (nonatomic) TMMovieGalleryRouterCompletion completion;


@end


@interface TMMovieGalleryRouter (TMMovieGalleryRouterProtocol) <TMMovieGalleryRouterProtocol>
@end

NS_ASSUME_NONNULL_END
