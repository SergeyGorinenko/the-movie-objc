//
//  UIImageView+Downloading.m
//  NetworkKit
//
//  Created by Serhii Horinenko on 26.04.2024.
//

#import "UIImageView+Downloading.h"

/** Table of the image downloading tasks. */
static NSMapTable *sUIImageViewDownloadingTasks_;

/** The queue for image downloading tasks. */
static dispatch_queue_t sUIImageDownloadingTasksQueue_;

/** A tag that marks an activity indicator view among subviews of the image view. */
const NSInteger kUIImageViewActivityViewTag = 82934;


@implementation UIImageView (Downloading)

// MARK: - Private properties

/** Creates a table of the image downloading tasks. */
+ (NSMapTable *)downloadTasks {
    if (nil == sUIImageViewDownloadingTasks_) {
        sUIImageViewDownloadingTasks_ = [NSMapTable mapTableWithKeyOptions:NSPointerFunctionsWeakMemory valueOptions:NSPointerFunctionsWeakMemory];
    }
    return sUIImageViewDownloadingTasks_;
}

/** Creates a queue for image downloading tasks. */
+ (dispatch_queue_t)downloadingTasksQueue {
    if (nil == sUIImageDownloadingTasksQueue_) {
        sUIImageDownloadingTasksQueue_ = dispatch_queue_create( "com.uiimageview.downloading.tasks", DISPATCH_QUEUE_SERIAL);
    }
    return sUIImageDownloadingTasksQueue_;
}

// MARK: - Public methods

- (void)setRemotePath:(NSString *)remotePath {
    __weak typeof(self) weakSelf = self;
    dispatch_async(UIImageView.downloadingTasksQueue, ^{
        [weakSelf cancelDownloadingTask];

        NSString *cachePath = [weakSelf cachePath:remotePath];
        NSURL *cacheURL = [NSURL fileURLWithPath:cachePath];
        CIImage *cacheImage = [CIImage imageWithContentsOfURL:cacheURL];
        
        if (cacheImage == nil) {
            [weakSelf showActivityIndicator];
            NSURLSessionDownloadTask *task = [NSURLSession.sharedSession downloadTaskWithURL:[NSURL URLWithString:remotePath]
                                                                           completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                if (!error) {
                    NSFileManager *fileManager = [NSFileManager defaultManager];
                    if ([fileManager moveItemAtURL:location toURL:cacheURL error:nil]) {
                        CIImage *cacheImage = [CIImage imageWithContentsOfURL:cacheURL];
                        [weakSelf setCIImage:cacheImage];
                    }
                }
                [weakSelf removeDownloadingTask];
                [weakSelf hideActivityIndicator];
            }];
            [weakSelf addDownloadingTask:task];
            [task resume];
        } else {
            [weakSelf setCIImage:cacheImage];
        }
    });
}

- (void)cancelDownloading {
    __weak typeof(self) weakSelf = self;
    dispatch_async(UIImageView.downloadingTasksQueue, ^{
        [weakSelf cancelDownloadingTask];
    });
}

// MARK: - Private methods

/**
 Local path for the remote resource.
 
 @param remotePath remote url path.
 @return Local cache path.
 */
- (NSString *)cachePath:(NSString *)remotePath {
    NSString *resultPath = nil;
    NSFileManager *fileManager = NSFileManager.defaultManager;
    NSError *error = nil;
    NSString *cacheDirectory = [[fileManager URLForDirectory:NSCachesDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:&error] path];
    if (error) {
        NSLog(@"UIImageView: cachePath: Error: %@", error.debugDescription);
    } else {
        resultPath = [NSString stringWithFormat:@"%@/%@.%@", cacheDirectory, @(remotePath.hash).stringValue, remotePath.pathExtension];
    }
    return resultPath;
}

/** Display activity indicator view. */
- (void)showActivityIndicator {
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        UIActivityIndicatorView *indicator = [weakSelf viewWithTag:kUIImageViewActivityViewTag];
        if (!indicator) {
            indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleMedium];
            indicator.tag = kUIImageViewActivityViewTag;
        }
        indicator.center = CGPointMake(floorf(weakSelf.bounds.size.width / 2.0), floorf(weakSelf.bounds.size.height / 2.0));
        [indicator startAnimating];
        [weakSelf addSubview:indicator];
    });
}

/** Hide activity indicator view. */
- (void)hideActivityIndicator {
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        UIActivityIndicatorView *indicator = [weakSelf viewWithTag:kUIImageViewActivityViewTag];
        [indicator removeFromSuperview];
    });
}

/**
 Sets image value.
 
 @param ciImage core image
 */
- (void)setCIImage:(CIImage *)ciImage {
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        weakSelf.image = [UIImage imageWithCIImage:ciImage];
    });
}

/**
 Adds a downloading task to the table.
 
 @param task downloading task to add.
 */
- (void)addDownloadingTask:(NSURLSessionDownloadTask *)task {
    [UIImageView.downloadTasks setObject:task forKey:self];
}

/** Remove downloading task for the image view. */
- (void)removeDownloadingTask {
    [UIImageView.downloadTasks removeObjectForKey:self];
}

/** Cancel downloading task for the image view. */
- (void)cancelDownloadingTask {
    [[UIImageView.downloadTasks objectForKey:self] cancel];
    [self removeDownloadingTask];
}

@end
