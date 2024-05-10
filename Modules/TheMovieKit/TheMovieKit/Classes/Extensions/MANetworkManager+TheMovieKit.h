//
//  MANetworkManager+TheMovieKit.h
//  TheMovieKit
//
//  Created by Serhii Horinenko on 09.05.2024.
//

#import <TheMovieAPI/TheMovieAPI.h>

NS_ASSUME_NONNULL_BEGIN

/** MANetworkManager extention to confirm TMMovieDataProvider protocol */
@interface MANetworkManager () <TMMovieDataProvider>
@end

NS_ASSUME_NONNULL_END
