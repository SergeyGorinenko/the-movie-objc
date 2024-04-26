//
//  TMMovieInteractor.h
//  TheMovieKit
//
//  Created by Serhii Horinenko on 25.04.2024.
//

#import <Foundation/Foundation.h>
#import <TheMovieCore/TheMovieCore.h>
#import <TheMovieAPI/TheMovieAPI.h>

NS_ASSUME_NONNULL_BEGIN

@interface TMMovieInteractor : NSObject

- (void)loadFirstPage:(void (^)(NSArray <TMMovieModel *>*movies, NSError *error))completion;
- (void)loadNextPage:(void (^)(NSArray <TMMovieModel *>*movies, NSError *error))completion;
- (void)loadPage:(NSInteger)page completion:(void (^)(NSArray <TMMovieModel *>*movies, NSError *error))completion;

@end

NS_ASSUME_NONNULL_END
