//
//  NKRefreshControl.m
//  NetworkKit
//
//  Created by Serhii Horinenko on 27.04.2024.
//

#import "NKRefreshControl.h"
#import <UIKit/UIKit.h>


@interface NKRefreshControl ()

/** Reference to an activity indicator view. */
@property (nonatomic) UIActivityIndicatorView *activityView;

/** Reference to a refresh control height constraint. */
@property (nonatomic) NSLayoutConstraint *heightConstraint;

@end


@implementation NKRefreshControl

- (instancetype)initWithActivityIndicatorStyle:(UIActivityIndicatorViewStyle)style {
    self = [super init];
    if (self) {
        [self setupActivityView:style];
        self.clipsToBounds = YES;
    }
    return self;
}

/** Returns tint color for the refresh control. */
- (UIColor *)tintColor {
    return self.activityView.color;
}

/** Sets tint color for the refresh control. */
- (void)setTintColor:(UIColor *)color {
    self.activityView.color = color;
}

/** Creates activity indicator view and placed it into refresh control. */
- (void)setupActivityView:(UIActivityIndicatorViewStyle)style {
    UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:style];
    activityView.hidesWhenStopped = NO;
    activityView.translatesAutoresizingMaskIntoConstraints = false;

    [self addSubview:activityView];

    self.heightConstraint = [NSLayoutConstraint constraintWithItem:self
                                                         attribute:NSLayoutAttributeHeight
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:nil
                                                         attribute:NSLayoutAttributeNotAnAttribute
                                                        multiplier:1.0
                                                          constant:0];
    [self addConstraints:@[
        self.heightConstraint,
        [NSLayoutConstraint constraintWithItem:self
                                     attribute:NSLayoutAttributeCenterX
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:activityView
                                     attribute:NSLayoutAttributeCenterX
                                    multiplier:1.0
                                      constant:0.0],
        [NSLayoutConstraint constraintWithItem:self
                                     attribute:NSLayoutAttributeCenterY
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:activityView
                                     attribute:NSLayoutAttributeCenterY
                                    multiplier:1.0
                                      constant:0.0],
    ]];
    self.activityView = activityView;
}

- (void)setHeight:(CGFloat)height {
    if (height >= 0) {
        self.heightConstraint.constant = height;
    } else {
        self.heightConstraint.constant = 0;
    }
}

- (void)beginRefreshing {
    if (!self.activityView.isAnimating) {
        [self.activityView startAnimating];

        [self sendActionsForControlEvents:UIControlEventValueChanged];
    }
}

- (void)endRefreshing {
    [self.activityView stopAnimating];
}

@end
