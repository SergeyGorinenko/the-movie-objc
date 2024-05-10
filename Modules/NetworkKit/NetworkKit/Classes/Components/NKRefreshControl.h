//
//  NKRefreshControl.h
//  NetworkKit
//
//  Created by Serhii Horinenko on 27.04.2024.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NKRefreshControl : UIControl

@property (null_resettable, nonatomic, strong) UIColor *tintColor;

/**
 An instance initialization function that takes activity indicator style as a parameter.
 
 @param style The visual style of the progress indicator.
 @return An instance of the class.
  */
- (instancetype)initWithActivityIndicatorStyle:(UIActivityIndicatorViewStyle)style;

/**
 Sets height for the refresh control.
 
 @param height Value for the height.
 */
- (void)setHeight:(CGFloat)height;

/** Begins refresh animation. */
- (void)beginRefreshing;

/** Ends refresh animation. */
- (void)endRefreshing;

@end

NS_ASSUME_NONNULL_END
