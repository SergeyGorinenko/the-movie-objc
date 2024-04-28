//
//  TMMovieGalleryViewController.m
//  TheMovieKit
//
//  Created by Serhii Horinenko on 25.04.2024.
//

#import "TMMovieGalleryViewController.h"
#import "TMMovieGalleryLayout.h"
#import "TMMovieGalleryCell.h"
#import <NetworkKit/NetworkKit.h>

const CGFloat kTMMovieGalleryRefreshDefaultHeight = 44.0;
const CGFloat kTMMovieGalleryRefreshThreshold = 160;
const NSTimeInterval kTMMovieGalleryAnimationDuration = 0.5;


@interface TMMovieGalleryViewController ()

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic) NKRefreshControl *bottomRefreshControl;

@end


@implementation TMMovieGalleryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.collectionView.collectionViewLayout = TMMovieGalleryLayout.layout;
    self.collectionView.allowsSelection = true;

    [self setupTopRefreshControl];
    [self setupBottomRefreshControl];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self.presenter configureView];
}

- (void)setupTopRefreshControl {
    UIRefreshControl *refreshControl = UIRefreshControl.new;
    [refreshControl setTintColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:1]];
    [refreshControl addTarget:self action:@selector(pullTopToRefreshAction:) forControlEvents:UIControlEventValueChanged];
    self.collectionView.refreshControl = refreshControl;
}

- (void)setupBottomRefreshControl {
    NKRefreshControl *refreshControl = [[NKRefreshControl alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleMedium];
    [refreshControl setTintColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:1]];
    [refreshControl addTarget:self action:@selector(pullBottomToRefreshAction:) forControlEvents:UIControlEventValueChanged];
    refreshControl.translatesAutoresizingMaskIntoConstraints = false;

    [self.collectionView addSubview:refreshControl];
    [self.collectionView bringSubviewToFront:refreshControl];
    
    UILayoutGuide *frameLayoutGuide = self.collectionView.safeAreaLayoutGuide;
    [self.collectionView addConstraints:@[
        [NSLayoutConstraint constraintWithItem:refreshControl
                                     attribute:NSLayoutAttributeLeft
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:frameLayoutGuide
                                     attribute:NSLayoutAttributeLeft
                                    multiplier:1.0
                                      constant:0.0],
        [NSLayoutConstraint constraintWithItem:refreshControl
                                     attribute:NSLayoutAttributeRight
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:frameLayoutGuide
                                     attribute:NSLayoutAttributeRight
                                    multiplier:1.0
                                      constant:0.0],
        [NSLayoutConstraint constraintWithItem:refreshControl
                                     attribute:NSLayoutAttributeBottom
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:frameLayoutGuide
                                     attribute:NSLayoutAttributeBottom
                                    multiplier:1.0
                                      constant:0]
    ]];
    self.bottomRefreshControl = refreshControl;
}

- (void)pullTopToRefreshAction:(UIRefreshControl *)sender {
   [self.presenter beganTopRefreshing];
}

- (void)pullBottomToRefreshAction:(UIRefreshControl *)sender {
   [self.presenter beganBottomRefreshing];
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
    TMMovieGalleryCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:TMMovieGalleryCell.defaultIdentifier 
                                                                              forIndexPath:indexPath];
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


// MARK: - UIScrollViewDelegate

@interface TMMovieGalleryViewController (UIScrollViewDelegate) <UIScrollViewDelegate>
@end


@implementation TMMovieGalleryViewController (UIScrollViewDelegate)

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat safeAreaInsetsTop = scrollView.safeAreaInsets.top;
    CGFloat safeAreaInsetsBottom = scrollView.safeAreaInsets.bottom;
    CGFloat contentHeight = scrollView.contentSize.height;
    CGFloat contentOffsetY = scrollView.contentOffset.y;
    CGFloat frameHeight = scrollView.frame.size.height;
    
    CGFloat maxBottom = MIN(safeAreaInsetsTop + contentHeight, frameHeight - safeAreaInsetsBottom);

    CGFloat diff = maxBottom - (contentHeight - contentOffsetY);
    [self.bottomRefreshControl setHeight:diff];
    if (diff > kTMMovieGalleryRefreshThreshold) {
        [self beginBottmRefreshing];
    }
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

- (void)beginBottmRefreshing {
    [self.collectionView setContentInset:UIEdgeInsetsMake(0, 0, kTMMovieGalleryRefreshDefaultHeight, 0)];
    [self.bottomRefreshControl beginRefreshing];
}

- (void)endBottomRefreshing {
    [self.bottomRefreshControl endRefreshing];
    [UIView animateWithDuration:0.5 animations:^{
        [self.collectionView setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    }];
}

@end
