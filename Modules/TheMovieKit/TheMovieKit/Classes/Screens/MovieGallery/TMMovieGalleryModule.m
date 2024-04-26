//
//  TMMovieGalleryModule.m
//  TheMovieKit
//
//  Created by Serhii Horinenko on 25.04.2024.
//

#import "TMMovieGalleryModule.h"
#import "TMMovieGalleryInteractor.h"
#import "TMMovieGalleryRouter.h"
#import "TMMovieGalleryPresenter.h"
#import "TMMovieGalleryViewController.h"

@implementation TMMovieGalleryModule

+ (UIViewController *)build:(void (^)(id result, NSError *error))completion {
    NSBundle *bundle = [NSBundle bundleForClass:TMMovieGalleryModule.class];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"TheMovieKit" bundle:bundle];
    TMMovieGalleryViewController *view = [storyboard instantiateViewControllerWithIdentifier:@"movieGalleryStoryboardIdentifier"];
    
    TMMovieGalleryInteractor *interactor = TMMovieGalleryInteractor.new;
    TMMovieGalleryPresenter *presenter = TMMovieGalleryPresenter.new;
    TMMovieGalleryRouter *router = TMMovieGalleryRouter.new;

    presenter.view = view;
    presenter.interactor = interactor;
    presenter.router = router;

    view.presenter = presenter;
    router.viewController = view;
    router.completion = completion;
    
    return view;
}

@end
