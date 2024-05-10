//
//  TMMovieConfiguration.h
//  TheMovieKit
//
//  Created by Serhii Horinenko on 09.05.2024.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TMMovieConfiguration : NSObject

@property (nonatomic) NSString *baseImageUrl;
@property (nonatomic) NSArray <NSString *>*imageSizes;

+ (instancetype)configurationWithDictionary:(NSDictionary *)representation;
- (instancetype)init NS_UNAVAILABLE;
- (NSString *)basePosterUrl;

@end

NS_ASSUME_NONNULL_END
