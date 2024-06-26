//
//  ViewController.m
//  TheMovieObjC
//
//  Created by Serhii Horinenko on 24.04.2024.
//

#import "ViewController.h"
#import <TheMovieKit/TheMovieKit.h>
#import <TheMovieCore/TheMovieCore.h>

@interface ViewController ()

@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    // Create movie gallery module
    __weak typeof(self) weakSelf = self;
    UIViewController *controller = [TMMovieGalleryModule build:^(id  _Nonnull result, NSError * _Nonnull error) {
        if (error) {
            [weakSelf presentError:error];
        }
    }];
    [controller setModalPresentationStyle:UIModalPresentationFullScreen];
    
    // Present view controller of movie gallery module
    [self presentViewController:controller animated:NO completion:nil];
}

- (void)presentError:(NSError *)error {
    NSString *message = error.userInfo[NSLocalizedDescriptionKey];
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"Warning", nil)
                                                                        message:NSLocalizedString(message, nil)
                                                                 preferredStyle:UIAlertControllerStyleAlert];
    [controller addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Ok", nil)
                                                   style:UIAlertActionStyleCancel
                                                 handler:nil]];
    [self presentViewController:controller animated:YES completion:nil];
}

@end
