//
//  TMMovieGalleryModule.h
//  TheMovieKit
//
//  Created by Serhii Horinenko on 25.04.2024.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TMMovieGalleryModule : NSObject

+ (UIViewController *)build:(void (^)(id result, NSError *error))completion;

@end

NS_ASSUME_NONNULL_END
