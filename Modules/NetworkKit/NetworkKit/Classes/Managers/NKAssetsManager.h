//
//  NKAssetsManager.h
//  NetworkKit
//
//  Created by Serhii Horinenko on 26.04.2024.
//

#import <Foundation/Foundation.h>
#import <NetworkKit/NKAssetDownloadProtocol.h>

NS_ASSUME_NONNULL_BEGIN

@interface NKAssetsManager : NSObject

+ (instancetype)manager:(id<NKAssetDownloadProtocol>)downloader;

+ (instancetype)new UNAVAILABLE_ATTRIBUTE;
- (id)init UNAVAILABLE_ATTRIBUTE;

- (void)setImageURL:(NSURL *)url completion:(void (^)(NSURL *image, NSError *error))completion;
- (void)cancelDownloading:(id)subscriber;

@end

NS_ASSUME_NONNULL_END
