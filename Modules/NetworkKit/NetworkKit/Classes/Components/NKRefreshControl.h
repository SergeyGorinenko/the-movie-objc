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

- (instancetype)initWithActivityIndicatorStyle:(UIActivityIndicatorViewStyle)style;

- (void)setHeight:(CGFloat)height;

- (void)beginRefreshing;
- (void)endRefreshing;

@end

NS_ASSUME_NONNULL_END
