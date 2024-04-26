//
//  TMMovieGalleryViewController.m
//  TheMovieKit
//
//  Created by Serhii Horinenko on 25.04.2024.
//

#import "TMMovieGalleryViewController.h"
#import "TMMovieGalleryCell.h"

@interface TMMovieGalleryViewController ()

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end


@implementation TMMovieGalleryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self.presenter configureView];
}

@end


// MARK: - UICollectionViewDataSource

@interface TMMovieGalleryViewController (UICollectionViewDataSource) <UICollectionViewDataSource>
@end


@implementation TMMovieGalleryViewController (UICollectionViewDataSource)

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.presenter.numberOfSections;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.presenter numberOfItemsInSection:section];
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    TMMovieGalleryCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:TMMovieGalleryCell.defaultIdentifier forIndexPath:indexPath];
    [self.presenter configure:cell indexPath:indexPath];
    return cell;
}

@end


// MARK: - UICollectionViewDelegate

@interface TMMovieGalleryViewController (UICollectionViewDelegate) <UICollectionViewDelegate>
@end


@implementation TMMovieGalleryViewController (UICollectionViewDelegate)

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
}

@end


// MARK: - TMMovieGalleryViewProtocol

@implementation TMMovieGalleryViewController (TMMovieGalleryViewProtocol)

- (void)reloadData {
    [self.collectionView reloadData];
}

@end
