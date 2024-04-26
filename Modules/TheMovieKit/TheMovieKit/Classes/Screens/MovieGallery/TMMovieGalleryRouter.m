//
//  TMMovieGalleryRouter.m
//  TheMovieKit
//
//  Created by Serhii Horinenko on 25.04.2024.
//

#import "TMMovieGalleryRouter.h"

@implementation TMMovieGalleryRouter

@end


// MARK: - TMMovieGalleryRouterProtocol

@implementation TMMovieGalleryRouter (TMMovieGalleryRouterProtocol)

- (void)presentError:(NSError *)error {
    NSString *message = error.userInfo[NSLocalizedDescriptionKey];
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"Warning", nil)
                                                                        message:NSLocalizedString(message, nil)
                                                                 preferredStyle:UIAlertControllerStyleAlert];
    [controller addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Ok", nil)
                                                   style:UIAlertActionStyleCancel
                                                 handler:nil]];
    [self.viewController presentViewController:controller animated:YES completion:nil];
}

@end
