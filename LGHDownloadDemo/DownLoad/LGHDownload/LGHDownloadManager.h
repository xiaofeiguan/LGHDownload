//
//  LGHDownloadManager.h
//  DownLoad
//
//  Created by 小肥观 on 2020/6/15.
//  Copyright © 2020 share. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LGHSession.h"
NS_ASSUME_NONNULL_BEGIN

// 缓存主目录(caches)
#define LGHCachesDirectory [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]stringByAppendingPathComponent:@"LGHCache"]

// 文件格式后缀(mp3, mp4, .....)
#define LGHFileName(url)  [[url componentsSeparatedByString:@"/"] lastObject]

// 文件的存放路径
#define LGHFileFullpath(url) [LGHCachesDirectory stringByAppendingPathComponent:LGHFileName(url)]

// 文件的已下载长度
#define LGHDownloadLength(url) [[[NSFileManager defaultManager] attributesOfItemAtPath:LGHFileFullpath(url) error:nil][NSFileSize] integerValue]

// 存储文件信息的路径（caches）
#define LGHDownloadDetailPath [LGHCachesDirectory stringByAppendingPathComponent:@"LGHData.data"]


/** 下载任务时该任务对应的状态 ： 是否可以下载为什么不能下载*/
typedef NS_ENUM(NSInteger, LGHDownloadTaskState) {
    /** url为空 */
    LGHDownloadTaskStateUrlNil = 0,
    /** url格式不正确 */
    LGHDownloadTaskStateUrlRrror ,
    /** 等待下载 */
    LGHDownloadTaskStateWaiting,
    /** 下载中 */
    LGHDownloadTaskStateLoading,
    /** 下载暂停 */
    LGHDownloadTaskStatePause,
    /** 下载完成 */
    LGHDownloadTaskStateCompleted,
    /** 下载失败 */
    LGHDownloadTaskStateFailed,
    /** 没有这个任务 */
    LGHDownloadTaskStateNoTask,
    /** 可以下载  */
    LGHDownloadTaskStateCanDownload
};
@interface LGHDownloadManager : NSObject
/**
 *  单例
 *
 *  @return 返回单例对象
 */
+ (instancetype)sharedInstance;
/**
 同时下载任务数量
 超过最大下载数，任务会等待下载，并依次执行，但是杀死程序后，这些等待的任务将不会依次下载，需要手动调用恢复下载方法
 @param maximumConnections 数量(默认为1)
 */
- (void)setMaximumConnection:(NSInteger)maximumConnections;
/**
 开启下载任务
 
 @param url 下载地址
 @param progressBlock 进度回调
 @param stateBlock 状态回调
 */
- (LGHDownloadTaskState)download:(NSString *)url progress:(LGHDownloadingBlock)progressBlock state:(LGHDownloadStateBlock)stateBlock;

/**
 恢复下载任务 (不可用于创建任务。暂停、失败和等待中的任务可以调用 )
 
 @param url 任务的下载地址
 */
- (void)resumeDownload:(NSString *)url;

/**
 暂停下载任务
 
 @param url 任务的下载地址
 */
- (void)pauseDownloadTaskWithUrl:(NSString *)url;

/**
 删除对应url任务
 
 @param url 下载地址
 */
- (void)deleteDownloadTaskWithUrl:(NSString *)url;

/**
 清空所有下载任务 (下载中和下载完成都会清空)
 */
- (void)deleteAllDownloadTask;

/**
 根据url获取下载session
 
 @param url 下载地址
 */
- (LGHSession *)getDownloadSessionWithUrlString:(NSString *)url;
/**
 根据url获取下载状态
 @param url 下载地址
 */
- (LGHDownloadState)getDownloadStateWithUrlString:(NSString *)url;

/**
 获取下载完成数组
 
 @return 数组
 */
- (NSArray *)getDownloadedArr;
/**
 获取下载完成数组
 
 @return 数组
 */
- (NSArray *)getDownloadingArr;
@end

NS_ASSUME_NONNULL_END
