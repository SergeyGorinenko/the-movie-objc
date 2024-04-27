//
//  TMMovieGalleryCell.m
//  TheMovieKit
//
//  Created by Serhii Horinenko on 25.04.2024.
//

#import "TMMovieGalleryCell.h"
#import <NetworkKit/NetworkKit.h>

@interface TMMovieGalleryCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *releaseLabel;
@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;

@end


@implementation TMMovieGalleryCell

+ (NSString *)defaultIdentifier {
    return @"movieGalleryCellIdentifier";
}

- (void)prepareForReuse {
    [super prepareForReuse];
    [self.imageView cancelDownloading];
}

- (IBAction)clickButtonAction:(id)sender {
}

@end


@implementation TMMovieGalleryCell (TMMovieGalleryCellProtocol)

- (void)setTitle:(NSString *)title {
    self.titleLabel.text = title;
}

- (void)setRelease:(NSString *)release {
    self.releaseLabel.text = release;
}

- (void)setRating:(NSString *)rating {
    self.ratingLabel.text = rating;
}

- (void)setRemotePath:(NSString *)remotePath {
    [self.imageView setRemotePath:remotePath];
}

@end
