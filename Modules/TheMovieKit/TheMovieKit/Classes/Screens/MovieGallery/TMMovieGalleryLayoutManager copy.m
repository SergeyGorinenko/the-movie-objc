//
//  TMMovieGalleryLayoutManager.m
//  TheMovieKit
//
//  Created by Serhii Horinenko on 26.04.2024.
//

#import "TMMovieGalleryLayoutManager.h"

@interface TMMovieGalleryLayoutManager ()

@property (nonatomic) UICollectionViewLayout *layout;

@end


@implementation TMMovieGalleryLayoutManager

- (instancetype)init {
    if (nil != (self = [super init])) {
        self.layout = [self layout];
        self.isFooterShown = false;
    }
    return self;
}

- (UICollectionViewLayout *)layout {
    // mainItem
    NSCollectionLayoutSize *mainItemSize = [NSCollectionLayoutSize sizeWithWidthDimension:[NSCollectionLayoutDimension fractionalWidthDimension:2.0/3.0]
                                                                          heightDimension:[NSCollectionLayoutDimension fractionalHeightDimension:1]];
    NSCollectionLayoutItem *mainItem = [NSCollectionLayoutItem itemWithLayoutSize:mainItemSize];

    // pairItem
    NSCollectionLayoutSize *pairItemSize = [NSCollectionLayoutSize sizeWithWidthDimension:[NSCollectionLayoutDimension fractionalWidthDimension:1]
                                                                          heightDimension:[NSCollectionLayoutDimension fractionalHeightDimension:0.5]];
    NSCollectionLayoutItem *pairItem = [NSCollectionLayoutItem itemWithLayoutSize:pairItemSize];

    // trailingGroup
    NSCollectionLayoutSize *trailingGroupSize = [NSCollectionLayoutSize sizeWithWidthDimension:[NSCollectionLayoutDimension fractionalWidthDimension:1.0/3.0]
                                                                               heightDimension:[NSCollectionLayoutDimension fractionalHeightDimension:1]];
    NSCollectionLayoutGroup *trailingGroup = [NSCollectionLayoutGroup verticalGroupWithLayoutSize:trailingGroupSize
                                                                                         subitems:@[pairItem, pairItem]];

    // mainWithPairGroup
    NSCollectionLayoutSize *mainWithPairGroupSize = [NSCollectionLayoutSize sizeWithWidthDimension:[NSCollectionLayoutDimension fractionalWidthDimension:1]
                                                                                   heightDimension:[NSCollectionLayoutDimension fractionalWidthDimension:1]];
    NSCollectionLayoutGroup *mainWithPairGroup = [NSCollectionLayoutGroup horizontalGroupWithLayoutSize:mainWithPairGroupSize
                                                                                               subitems:@[mainItem, trailingGroup]];

    // tripletItem
    NSCollectionLayoutSize *tripletItemSize = [NSCollectionLayoutSize sizeWithWidthDimension:[NSCollectionLayoutDimension fractionalWidthDimension:1.0/3.0]
                                                                             heightDimension:[NSCollectionLayoutDimension fractionalHeightDimension:1]];
    NSCollectionLayoutItem *tripletItem = [NSCollectionLayoutItem itemWithLayoutSize:tripletItemSize];

    // tripletGroup
    NSCollectionLayoutSize *tripletGroupSize = [NSCollectionLayoutSize sizeWithWidthDimension:[NSCollectionLayoutDimension fractionalWidthDimension:1]
                                                                              heightDimension:[NSCollectionLayoutDimension fractionalWidthDimension:3.0/6.0]];
    NSCollectionLayoutGroup *tripletGroup = [NSCollectionLayoutGroup horizontalGroupWithLayoutSize:tripletGroupSize
                                                                                          subitems:@[tripletItem, tripletItem, tripletItem]];

    // mainWithPairReversedGroup
    NSCollectionLayoutSize *mainWithPairReversedGroupSize = [NSCollectionLayoutSize sizeWithWidthDimension:[NSCollectionLayoutDimension fractionalWidthDimension:1]
                                                                                           heightDimension:[NSCollectionLayoutDimension fractionalWidthDimension:1]];
    NSCollectionLayoutGroup *mainWithPairReversedGroup = [NSCollectionLayoutGroup horizontalGroupWithLayoutSize:mainWithPairReversedGroupSize
                                                                                                       subitems:@[trailingGroup, mainItem]];

    // nestedGroup
    NSCollectionLayoutSize *nestedGroupSize = [NSCollectionLayoutSize sizeWithWidthDimension:[NSCollectionLayoutDimension fractionalWidthDimension:1]
                                                                             heightDimension:[NSCollectionLayoutDimension fractionalWidthDimension:15.0/6.0]];
    NSCollectionLayoutGroup *nestedGroup = [NSCollectionLayoutGroup verticalGroupWithLayoutSize:nestedGroupSize
                                                                                       subitems:@[mainWithPairGroup, tripletGroup, mainWithPairReversedGroup]];

    NSCollectionLayoutSection *section = [NSCollectionLayoutSection sectionWithGroup:nestedGroup];

    // sectionFooter
    NSCollectionLayoutSize *footerSize = [NSCollectionLayoutSize sizeWithWidthDimension:[NSCollectionLayoutDimension fractionalWidthDimension:1]
                                                                        heightDimension:[NSCollectionLayoutDimension absoluteDimension:(self.isFooterShown ? 44 : 0)]];
    NSCollectionLayoutBoundarySupplementaryItem *sectionFooter = [NSCollectionLayoutBoundarySupplementaryItem boundarySupplementaryItemWithLayoutSize: footerSize
                                                                                                                                          elementKind: UICollectionElementKindSectionFooter
                                                                                                                                            alignment: NSRectAlignmentBottom];
    section.boundarySupplementaryItems = @[sectionFooter];

    return [[UICollectionViewCompositionalLayout alloc] initWithSection:section];
}

@end
