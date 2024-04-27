//
//  UIImageView+Downloading.h
//  NetworkKit
//
//  Created by Serhii Horinenko on 26.04.2024.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (Downloading)

- (void)setRemotePath:(NSString *)remotePath;
- (void)cancelDownloading;

@end

NS_ASSUME_NONNULL_END
