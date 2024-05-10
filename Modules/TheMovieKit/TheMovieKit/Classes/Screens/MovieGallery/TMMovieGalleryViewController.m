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

/** Value used to define bottom refresh control height */
const CGFloat kTMMovieGalleryRefreshDefaultHeight = 44.0;

/** The value used to determine the threshold at which the update begins for the bottom refresh control. */
const CGFloat kTMMovieGalleryRefreshThreshold = 160;


@interface TMMovieGalleryViewController ()

/** Collection view to display a list of movies. */
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

/** Bottom refresh control. */
@property (nonatomic) NKRefreshControl *bottomRefreshControl;

@end


@implementation TMMovieGalleryViewController

/** Called after the view has been loaded. Initializes the View user interface elements.*/
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.collectionView.collectionViewLayout = TMMovieGalleryLayout.layout;
    self.collectionView.allowsSelection = true;

    [self setupTopRefreshControl];
    [self setupBottomRefreshControl];
}

/** Called when the view is about to be dismissed, covered, or otherwise hidden. */
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self.presenter configureView];
}

/** Creates top refresh control. */
- (void)setupTopRefreshControl {
    UIRefreshControl *refreshControl = UIRefreshControl.new;
    [refreshControl setTintColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:1]];
    [refreshControl addTarget:self action:@selector(pullTopToRefreshAction:) forControlEvents:UIControlEventValueChanged];
    self.collectionView.refreshControl = refreshControl;
}

/** Creates bottom refresh control. */
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

/**
 Initiate the top refreshing of a scroll view’s contents.
 
 @param sender Top refresh control
 */
- (void)pullTopToRefreshAction:(UIRefreshControl *)sender {
   [self.presenter beganTopRefreshing];
}

/**
 Initiate the bottom refreshing of a scroll view’s contents.
 
 @param sender Bottom refresh control
 */
- (void)pullBottomToRefreshAction:(UIRefreshControl *)sender {
   [self.presenter beganBottomRefreshing];
}

@end


// MARK: - UICollectionViewDataSource

@interface TMMovieGalleryViewController (UICollectionViewDataSource) <UICollectionViewDataSource>
@end


@implementation TMMovieGalleryViewController (UICollectionViewDataSource)

/**
 Asks Presenter for the number of sections in the collection view.
 
 @param collectionView The collection view requesting this information.
 @return The number of sections in collectionView.
 */
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.presenter.numberOfSections;
}

/**
 Returns the number of movies in the specified section.

 @param collectionView The collection view requesting this information.
 @param section An index number identifying a section in collectionView. This index value is 0-based.
 @return The number of movies in section.
 */
- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.presenter numberOfItemsInSection:section];
}

/**
 Asks your data source object for the cell that corresponds to the specified item in the collection view.
 
 @param collectionView The collection view requesting this information.
 @param indexPath The index path that specifies the location of the item.
 @return A configured cell object. You must not return nil from this method.
 */
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

/** Tells the delegate that the movie cell at the specified index path was selected. */
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
}

@end


// MARK: - UIScrollViewDelegate

@interface TMMovieGalleryViewController (UIScrollViewDelegate) <UIScrollViewDelegate>
@end


@implementation TMMovieGalleryViewController (UIScrollViewDelegate)

/**
 Tells the delegate when the user scrolls the content view within the scroll view. Whenever the scroll offset reaches the refresh threshold, the bottom refresh control animation is triggered.
 */
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
