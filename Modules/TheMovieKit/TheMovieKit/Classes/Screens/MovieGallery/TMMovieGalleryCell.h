//
//  TMMovieGalleryCell.h
//  TheMovieKit
//
//  Created by Serhii Horinenko on 25.04.2024.
//

#import <UIKit/UIKit.h>
#import "TMMovieGalleryProtocols.h"

NS_ASSUME_NONNULL_BEGIN

@interface TMMovieGalleryCell : UICollectionViewCell

/** Defines the default cell identifier. */
+ (NSString *)defaultIdentifier;

@end


/** TMMovieGalleryCell extention to confirm TMMovieGalleryCellProtocol protocol */
@interface TMMovieGalleryCell (TMMovieGalleryCellProtocol) <TMMovieGalleryCellProtocol>
@end

NS_ASSUME_NONNULL_END
