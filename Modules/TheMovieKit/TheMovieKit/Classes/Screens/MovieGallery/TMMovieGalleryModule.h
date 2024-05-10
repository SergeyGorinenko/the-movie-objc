//
//  TMMovieGalleryModule.h
//  TheMovieKit
//
//  Created by Serhii Horinenko on 25.04.2024.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TMMovieGalleryModule : NSObject

/**
 This function creates and puts down movie gallery VIPER components and returns View element immediately.
 
 @param completion This closure is designed to communicate with its parent to notify of events or errors that the module cannot handle on its own. For example: to dismiss View.
 @return View component of VIPER module
 */
+ (UIViewController *)build:(void (^)(id result, NSError *error))completion;

@end

NS_ASSUME_NONNULL_END
