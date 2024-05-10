//
//  MAGetConfigurationAPI.h
//  TheMovieAPI
//
//  Created by Serhii Horinenko on 24.04.2024.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MAGetConfigurationAPI : NSObject

- (void)getConfiguration:(void (^)(NSDictionary *configurationRep, NSError *error))completion;

@end

NS_ASSUME_NONNULL_END
