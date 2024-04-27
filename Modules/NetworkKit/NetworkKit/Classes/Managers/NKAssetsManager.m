//
//  NKAssetsManager.m
//  NetworkKit
//
//  Created by Serhii Horinenko on 26.04.2024.
//

#import "NKAssetsManager.h"

@interface NKAssetsManager ()

@property (nonatomic) id<NKAssetDownloadProtocol> downloader;
@property (nonatomic) NSMutableDictionary <NSString *, NSMutableArray *>*subscribers;

@end


@implementation NKAssetsManager

+ (instancetype)manager:(id<NKAssetDownloadProtocol>)downloader {
    NKAssetsManager *manager = NKAssetsManager.new;
    manager.downloader = downloader;
    manager.subscribers = [@{} mutableCopy];
    return manager;
}

- (void)setImageURL:(NSURL *)url completion:(void (^)(NSURL *image, NSError *error))completion {
    NSMutableArray *subscribers = self.subscribers[url.absoluteString];
    if (subscribers != nil) {
        [subscribers addObject:completion];
    } else {
        NSMutableArray *subscribers = [@[completion] mutableCopy];
        self.subscribers[url.absoluteString] = subscribers;
    }
}

- (void)cancelDownloading:(id)subscriber {
    NSLog(@"cancelDownloading%@", subscriber);
}

@end
