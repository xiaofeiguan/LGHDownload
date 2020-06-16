//
//  LGHSession.h
//  DownLoad
//
//  Created by 小肥观 on 2020/6/15.
//  Copyright © 2020 share. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

/** 下载状态 */
typedef NS_ENUM(NSInteger, LGHDownloadState) {
    /** 没有该任务 */
    LGHDownloadStateNoTask = 0,
    /** 等待下载 */
    LGHDownloadStateWaiting,
    /** 下载中 */
    LGHDownloadStateLoading,
    /** 下载暂停 */
    LGHDownloadStatePause,
    /** 下载完成 */
    LGHDownloadStateCompleted,
    /** 下载失败 */
    LGHDownloadStateFailed,
};

/**
 下载中的回调
 
 @param progress 进度
 @param speed 速度
 @param remainingTime 剩余时间
 @param writtenSize 写入大小
 @param totalSize 总大小
 */
typedef void(^LGHDownloadingBlock)(CGFloat progress,NSString * speed,NSString *remianingTime,NSString *writtenSize,NSString *totalSize);

/**
 下载状态的回调
 
 @param state 下载状态
 */
typedef void(^LGHDownloadStateBlock)(LGHDownloadState state);

@interface LGHSession : NSObject<NSCoding>
/** 下载地址 */
@property (nonatomic, copy) NSString *url;

/** 开始下载时间 */
@property (nonatomic, strong) NSDate *startTime;

/** 文件名 */
@property (nonatomic, copy) NSString *fileName;

/** 文件总大小 */
@property (nonatomic, copy) NSString *totalSize;

/** 获得服务器这次请求 返回数据的总长度 */
@property (nonatomic, assign) NSInteger totalLength;

/** 已下载大小 */
@property (nonatomic, copy) NSString *totalBytesWritten;

/** 进度 */
@property (nonatomic, assign) float progress;

/** 下载任务 */
@property (nonatomic, strong) NSURLSessionDataTask *dataTask;
/** 创建流 */
@property (nonatomic, strong) NSOutputStream *stream;
/**  下载状态 */
@property (nonatomic, assign) LGHDownloadState downloadState;
/** 下载进度 */
@property (atomic, copy) LGHDownloadingBlock downloadingBlock;

/** 下载状态 */
@property (atomic, copy) LGHDownloadStateBlock stateBlock;
@end

NS_ASSUME_NONNULL_END
