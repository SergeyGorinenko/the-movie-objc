//
//  UIImageView+Downloading.h
//  NetworkKit
//
//  Created by Serhii Horinenko on 26.04.2024.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (Downloading)

/**
 Sets the image path value for the image view.
 
 @param remotePath A string for the path value of the image view.
 */
- (void)setRemotePath:(NSString *)remotePath;

/** Cancels downloading images. */
- (void)cancelDownloading;

@end

NS_ASSUME_NONNULL_END
