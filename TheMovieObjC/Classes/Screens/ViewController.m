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

@property (nonatomic) TMMovieInteractor *interactor;

@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.interactor = TMMovieInteractor.new;
    __weak typeof(self) weakSelf = self;
    [self.interactor loadFirstPage:^(NSArray<TMMovieModel *> * _Nonnull movies, NSError * _Nonnull error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (error) {
                [weakSelf presentError:error];
            } else {
                [movies enumerateObjectsUsingBlock:^(TMMovieModel * _Nonnull movie, NSUInteger idx, BOOL * _Nonnull stop) {
                    NSLog(@"ViewController: movie: \"%@\": %@", movie.title, movie.posterPath);
                }];
            }
        });
    }];
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
