//
//  TMMovieGalleryViewController.m
//  TheMovieKit
//
//  Created by Serhii Horinenko on 25.04.2024.
//

#import "TMMovieGalleryViewController.h"
#import "TMMovieGalleryLayout.h"
#import "TMMovieGalleryCell.h"

@interface TMMovieGalleryViewController ()

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end


@implementation TMMovieGalleryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.collectionView.collectionViewLayout = TMMovieGalleryLayout.layout;

    [self setupTopRefreshControl];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self.presenter configureView];
}

- (void)setupTopRefreshControl {
    UIRefreshControl *refreshControl = [UIRefreshControl new];
    refreshControl.tintColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:1];
    [refreshControl addTarget:self action:@selector(pullTopToRefreshAction:) forControlEvents:UIControlEventValueChanged];
    self.collectionView.refreshControl = refreshControl;
}

- (void)pullTopToRefreshAction:(UIRefreshControl *)sender
{
    [self.presenter beganTopRefreshing];
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

- (void)beginTopRefreshing {
    [self.collectionView.refreshControl beginRefreshing];
}

- (void)endTopRefreshing {
    [self.collectionView.refreshControl endRefreshing];
}

@end
