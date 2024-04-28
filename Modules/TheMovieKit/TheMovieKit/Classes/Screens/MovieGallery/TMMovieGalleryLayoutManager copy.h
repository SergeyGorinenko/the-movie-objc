//
//  TMMovieGalleryLayoutManager.h
//  TheMovieKit
//
//  Created by Serhii Horinenko on 26.04.2024.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TMMovieGalleryLayoutManager : NSObject

@property (nonatomic, readonly) UICollectionViewLayout *layout;
@property (nonatomic) BOOL isFooterShown;

@end

NS_ASSUME_NONNULL_END
