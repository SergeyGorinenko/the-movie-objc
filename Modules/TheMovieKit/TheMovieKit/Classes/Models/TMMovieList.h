//
//  TMMovieList.h
//  TheMovieKit
//
//  Created by Serhii Horinenko on 09.05.2024.
//

#import <Foundation/Foundation.h>
#import <TheMovieCore/TheMovieCore.h>

NS_ASSUME_NONNULL_BEGIN

@interface TMMovieList : NSObject

+ (NSArray <MCMovieModel *>*)movies:(NSDictionary *)representation basePosterUrl:(NSString *)basePosterUrl;
- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
