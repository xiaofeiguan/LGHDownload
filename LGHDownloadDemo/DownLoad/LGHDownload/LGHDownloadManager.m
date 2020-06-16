//
//  LGHDownloadManager.m
//  DownLoad
//
//  Created by 小肥观 on 2020/6/15.
//  Copyright © 2020 share. All rights reserved.
//

#import "LGHDownloadManager.h"

@interface LGHDownloadManager ()<NSURLSessionDataDelegate>
/**  最大下载数 */
@property (nonatomic, assign) NSInteger maximumConnections;
/**  全部任务 */
@property (nonatomic, strong) NSArray *allDownloadArr;
/**  下载完成的任务 */
@property (nonatomic, strong) NSMutableArray *downloadedArr;
/**  下载中的任务 (包括 等待下载、暂停、失败、下载中)*/
@property (nonatomic, strong) NSMutableArray *downloadingArr;
/**  正在处理的任务 (正在下载)  */
@property (nonatomic, strong) NSMutableArray *performingArr;
/**  等待处理的任务 （等待下载的任务）*/
@property (nonatomic, strong) NSMutableArray *performWaitArr;
/**  是否添加过监听 */
@property (nonatomic, assign) BOOL isAddNotification;
@end

@implementation LGHDownloadManager
#pragma mark -------------  懒加载 -----------------
- (NSArray *)allDownloadArr {
    if (!_allDownloadArr) {
        if ([self getAllSessions]) {
            _allDownloadArr = [self getAllSessions];
        } else {
            _allDownloadArr = [NSArray array];
        }
    }
    return _allDownloadArr;
}
- (NSMutableArray *)downloadedArr {
    if (!_downloadedArr) {
        if (self.allDownloadArr.firstObject) {
            _downloadedArr = self.allDownloadArr.firstObject;
        }else {
            _downloadedArr = [NSMutableArray array];
        }
    }
    return _downloadedArr;
}
- (NSMutableArray *)downloadingArr {
    if (!_downloadingArr) {
        if (self.allDownloadArr.lastObject) {
            _downloadingArr = self.allDownloadArr.lastObject;
        }else {
            _downloadingArr = [NSMutableArray array];
        }
        
    }
    return _downloadingArr;
}
- (NSMutableArray *)performingArr {
    if (!_performingArr) {
        _performingArr = [NSMutableArray array];
    }
    return _performingArr;
}
- (NSMutableArray *)performWaitArr {
    if (!_performWaitArr) {
        _performWaitArr = [NSMutableArray array];
    }
    return _performWaitArr;
}


#pragma mark -------- 单例的初始化 ---------
static LGHDownloadManager * _instance = nil;
+ (instancetype)sharedInstance{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[super allocWithZone:NULL]init];
        _instance.maximumConnections = 10000;
    });
    return _instance;
}
+(id)allocWithZone:(struct _NSZone *)zone {
    return [LGHDownloadManager sharedInstance];
}

-(id)copyWithZone:(struct _NSZone *)zone {
    return [LGHDownloadManager sharedInstance];
}


#pragma mark -------- 公开方法的实现 ---------

-(void)setMaximumConnection:(NSInteger)maximumConnections{
    if (maximumConnections) {
        self.maximumConnections = maximumConnections;
    }
}

-(LGHDownloadTaskState)download:(NSString *)url progress:(LGHDownloadingBlock)progressBlock state:(LGHDownloadStateBlock)stateBlock{
    //添加程序杀死监听
    if (!self.isAddNotification) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillTerminate:) name:UIApplicationWillTerminateNotification object:nil];
        self.isAddNotification = YES;
    }
    // URL检查是否可以下载
    if ([self checkCanDownload:url]!= LGHDownloadTaskStateCanDownload) {
        return [self checkCanDownload:url];
    }
    //创建缓存目录文件
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:LGHCachesDirectory]) {
        [fileManager createDirectoryAtPath:LGHCachesDirectory withIntermediateDirectories:YES attributes:nil error:NULL];
    }
    //开始任务
    // 返回的以一个task 第二个是strem
    NSArray *sessionInfos = [self resumeURLSession:url];
    
    //创建LGHSession 保存回调参数
    LGHSession *session = [[LGHSession alloc] init];
    session.url = url;
    if(progressBlock) session.downloadingBlock  = progressBlock;
    if(stateBlock) session.stateBlock = stateBlock;
    session.downloadState = LGHDownloadStateWaiting;
    if (session.stateBlock) session.stateBlock(LGHDownloadStateWaiting);
    session.dataTask = sessionInfos.firstObject;
    session.stream = sessionInfos.lastObject;
    [self addSession:session];

    // 开始任务
    if ([self isStartDownloadWithSession:session]) {
        [session.dataTask resume];
    }
    return  LGHDownloadTaskStateCanDownload;
}

/**
 恢复下载任务 (不可用于创建任务。暂停、失败和等待中的任务可以调用 )
 @param url 任务的下载地址
 */
- (void)resumeDownload:(NSString *)url{
    //添加程序杀死监听
    if (!self.isAddNotification) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillTerminate:) name:UIApplicationWillTerminateNotification object:nil];
        self.isAddNotification = YES;
    }
    
    LGHSession *session = [self getDownloadSessionWithUrlString:url];
    if (!session) {
        return;
    }
    if (session.downloadState==LGHDownloadStatePause || session.downloadState==LGHDownloadStateFailed) {
        if (session.dataTask) {
            if([self isStartDownloadWithSession:session]){
                [session.dataTask resume];
            }
        }else{
            //session.dataTask == nil,重新创建下载任务
           NSArray *sessionArr = [self resumeURLSession:session.url];
            session.dataTask = sessionArr.firstObject;
            session.stream = sessionArr.lastObject;
            //开始任务或等待下载
            if ([self isStartDownloadWithSession:session]) [session.dataTask resume];
            //保存session
            [self saveSessions];
        }
    }
}

/**
 暂停下载任务
 
 @param url 任务的下载地址
 */
- (void)pauseDownloadTaskWithUrl:(NSString *)url{
    LGHSession *session = [self getDownloadSessionWithUrlString:url];
    if (session.dataTask) {
        if (session.downloadState == LGHDownloadStateLoading) {
            session.downloadState = LGHDownloadStatePause;
            if (session.stateBlock) {
                session.stateBlock(LGHDownloadStatePause);
            }
            [self removeObjectWith:self.performingArr session:session];
        }
    }
    [self saveSessions];
}

/**
暂停所有的任务
*/
-(void)pauseAllDownloadTask{
    if (self.downloadingArr.count>0) {
        for (LGHSession *session in self.downloadingArr) {
            if (session && session.dataTask) {
                if (session.downloadState == LGHDownloadStateLoading||session.downloadState == LGHDownloadStateWaiting||session.downloadState==LGHDownloadStateFailed) {
                    [session.dataTask suspend];
                    session.downloadState = LGHDownloadStatePause;
                    if (session.stateBlock) {
                        session.stateBlock(LGHDownloadStatePause);
                    }
                }
            }
        }
    }
    [self saveSessions];
}

/**
 删除对应url任务
 
 @param url 下载地址
 */
- (void)deleteDownloadTaskWithUrl:(NSString *)url{
    LGHSession *session = [self getDownloadSessionWithUrlString:url];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (session && session.downloadState == LGHDownloadStateCompleted) {
        if ([self.downloadedArr containsObject:@{session.url:session}]) {
            [self.downloadedArr removeObject:@{session.url:session}];
            if ([fileManager fileExistsAtPath:LGHFileFullpath(url)]) {
                // 删除沙盒中的资源
                [fileManager removeItemAtPath:LGHFileFullpath(url) error:nil];
            }
        }
    }else{
        if ([self.downloadingArr containsObject:@{session.url:session}]) {
            [session.stream close];
            session.stream = nil;
            [self.downloadingArr removeObject:@{session.url:session}];
            if ([fileManager fileExistsAtPath:LGHFileFullpath(url)]) {
                // 删除沙盒中的资源
                [fileManager removeItemAtPath:LGHFileFullpath(url) error:nil];
            }
            
        }
    }
    //删除正在下载和等待下载的数组
    [self removeObjectWith:self.performingArr session:session];
    [self removeObjectWith:self.performWaitArr session:session];
    //开始下一个任务
    if (session.downloadState == LGHDownloadStateLoading){
        [self startNextDownloadTask];
    }
    [self saveSessions];
    
}

/**
 清空所有下载任务 (下载中和下载完成都会清空)
 */
- (void)deleteAllDownloadTask{
    //关闭下载任务的流
    for (NSDictionary *dic in self.downloadingArr) {
        for (NSString *url in dic.allKeys) {
            if (url){
                LGHSession *session = [dic objectForKey:url];
                [session.stream close];
                session.stream = nil;
            }
        }
    }
    [self.downloadingArr removeAllObjects];
    [self.downloadedArr removeAllObjects];
    [self saveSessions];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:LGHCachesDirectory]) {
        // 删除沙盒中所有资源
        [fileManager removeItemAtPath:LGHCachesDirectory error:nil];
    }
    if ([fileManager fileExistsAtPath:LGHDownloadDetailPath]) {
        // 删除沙盒中数据源
        [fileManager removeItemAtPath:LGHDownloadDetailPath error:nil];
    }
    [self.performWaitArr removeAllObjects];
    [self.performingArr removeAllObjects];
}


/**
根据url获取下载session

@param url 下载地址
*/
- (LGHSession *)getDownloadSessionWithUrlString:(NSString *)url {
    for (NSArray *array in self.allDownloadArr) {
        for (NSDictionary *dic in array) {
            if ([dic objectForKey:url]) return [dic objectForKey:url];
        }
    }
    return nil;
}

/**
 根据url获取下载状态
 @param url 下载地址
 */
- (LGHDownloadState)getDownloadStateWithUrlString:(NSString *)url{
    
    return LGHDownloadStateNoTask;
}

/**
 获取下载完成数组
 
 @return 数组
 */
- (NSArray *)getDownloadedArr{
    NSMutableArray *downArr = [NSMutableArray array];
    for (NSDictionary *dic in self.downloadedArr) {
        for (NSString *keyStr in dic.allKeys) {
            LGHSession *session = [dic objectForKey:keyStr];
            [downArr addObject:session];
        }
    }
    return downArr;
}
/**
 获取下载完成数组
 
 @return 数组
 */
- (NSArray *)getDownloadingArr{
    NSMutableArray *downArr = [NSMutableArray array];
    for (NSDictionary *dic in self.downloadingArr) {
        for (NSString *keyStr in dic.allKeys) {
            LGHSession *session = [dic objectForKey:keyStr];
            [downArr addObject:session];
        }
    }
    return downArr;
}


+ (void)handleEventsForBackgroundURLSession:(NSString *)identifier completionHandler:(void (^)(void))completionHandler{
    [LGHDownloadManager sharedInstance].backgroundCompletionHandler = completionHandler;
}

#pragma mark - NSURLSessionDataDelegate

-(void)URLSessionDidFinishEventsForBackgroundURLSession:(NSURLSession *)session{
    if (self.backgroundCompletionHandler) {
        self.backgroundCompletionHandler();
    }
}

-(void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSHTTPURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler{
    LGHSession *asSession = [self getDownloadSessionWithUrlString:[self getUrlStringWithTaskResponse:dataTask]];
    asSession.startTime = [NSDate date];
    [asSession.stream open];
    
    //获取服务器这次的请求，返回数据的总长度
    NSInteger totalLength = [response.allHeaderFields[@"Content-Length"] integerValue]+LGHDownloadLength(asSession.url);
    asSession.totalLength = totalLength;
    CGFloat totalSize = [self calculateFileSizeInUnit:(unsigned long long)totalLength];
    NSString *totalUnit = [self calculateUnit:(unsigned long long)totalLength];
    NSString *totalString = [NSString stringWithFormat:@"%.2f%@",totalSize,totalUnit];
    asSession.totalSize = totalString;
    [self saveSessions];
    // 接收这个请求，允许接收服务器的数据
    completionHandler(NSURLSessionResponseAllow);
}
/**
 * 接收到服务器返回的数据
 */
-(void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data{
    LGHSession *asSession = [self getDownloadSessionWithUrlString:[self getUrlStringWithTaskResponse:dataTask]];
    asSession.fileName = dataTask.response.suggestedFilename;
    //写入数据
    [asSession.stream write:data.bytes maxLength:data.length];
    //下载进度
    NSUInteger receivedSize = LGHDownloadLength(asSession.url);
    NSUInteger expectedSize = asSession.totalLength;
    CGFloat progress = (receivedSize/(CGFloat)expectedSize)*1.0;
    asSession.progress = progress;
    NSLog(@"%lf",progress);
    //已写入大小
    float totalBytesWrittenSize = [self calculateFileSizeInUnit:(unsigned long long)receivedSize];
    NSString *totalBytesWrittenUnit = [self calculateUnit:(unsigned long long)receivedSize];
    NSString *totalBytesWrittenStr = [NSString stringWithFormat:@"%.2f%@",totalBytesWrittenSize,totalBytesWrittenUnit];
    asSession.totalBytesWritten = totalBytesWrittenStr;
    // 每秒下载速度
    NSTimeInterval downloadTime = -1 * [asSession.startTime timeIntervalSinceNow];
    NSUInteger speed = receivedSize / downloadTime;
    if (speed == 0) { return; }
    float speedSize = [self calculateFileSizeInUnit:(unsigned long long)speed];
    NSString *speedUnit = [self calculateUnit:(unsigned long long)speed];
    NSString *speedStr = [NSString stringWithFormat:@"%.2f%@/S",speedSize,speedUnit];
    // 剩余下载时间
    NSMutableString *remainingTimeStr = [[NSMutableString alloc] init];
    unsigned long long remainingContentLength = expectedSize - receivedSize;
    int remainingTime = (int)(remainingContentLength / speed);
    
    int hours = remainingTime / 3600;
    int minutes = (remainingTime - hours * 3600) / 60;
    int seconds = remainingTime - hours * 3600 - minutes * 60;
    
    if(hours>0) {[remainingTimeStr appendFormat:@"%d 小时 ",hours];}
    if(minutes>0) {[remainingTimeStr appendFormat:@"%d 分 ",minutes];}
    if(seconds>0) {[remainingTimeStr appendFormat:@"%d 秒",seconds];}
    //状态回调
    asSession.downloadState = LGHDownloadStateLoading;
    [self saveSessions];
    if (asSession.stateBlock) {
        asSession.stateBlock(LGHDownloadStateLoading);
    }
    if (asSession.downloadingBlock) {
        asSession.downloadingBlock((double)progress, speedStr, remainingTimeStr, totalBytesWrittenStr, asSession.totalSize);
    }
}

/**
 *  下载完毕的调用 (下载成功或下载失败都会调用)
 *
 */

-(void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error{
    NSString *url = [NSString stringWithFormat:@"%@",[error.userInfo objectForKey:@"NSErrorFailingURLKey"]];
    LGHSession * asSession = [self getDownloadSessionWithUrlString:url];
    [asSession.stream close];
    asSession.stream = nil;
    if (error) {
        if (asSession.downloadState == LGHDownloadStateWaiting || asSession.downloadState == LGHDownloadStatePause) return;
        asSession.downloadState = LGHDownloadStateFailed;
        [self saveSessions];
        //正在处理任务中移除 (有错误)
        [self removeObjectWith:self.performingArr session:asSession];
        if (asSession.stateBlock) {
            asSession.stateBlock(LGHDownloadStateFailed);
        }
    }else{
        [self.downloadedArr addObject:@{asSession.url:asSession}];
        [self.downloadingArr removeObject:@{asSession.url:asSession}];
        [self removeObjectWith:self.performingArr session:asSession];
        asSession.downloadState = LGHDownloadStateCompleted;
        [self saveSessions]; // 先更新数据再返回回调
        if (asSession.stateBlock) asSession.stateBlock(LGHDownloadStateCompleted);
    }
    //开始下一个任务
    [self startNextDownloadTask];
}


#pragma mark - 程序杀死的监听回调

-(void)applicationWillTerminate{
    for (NSDictionary *dic in self.downloadingArr) {
        for (NSString *keyStr in dic.allKeys) {
            LGHSession *session = [dic objectForKey:keyStr];
            [self pauseDownloadTaskWithUrl:session.url];
        }
    }
}



#pragma mark - Tools

/**
 计算指定字节单位
 
 @param contentLength 需要计算的长度
 @return 单位
 */
- (NSString *)calculateUnit:(unsigned long long)contentLength
{
    if(contentLength >= pow(1024, 3)) { return @"GB";}
    else if(contentLength >= pow(1024, 2)) { return @"MB"; }
    else if(contentLength >= 1024) { return @"KB"; }
    else { return @"B"; }
}

/**
 计算指定字节大小
 
 @param contentLength 需要计算的长度
 @return 大小
 */
- (float)calculateFileSizeInUnit:(unsigned long long)contentLength
{
    if(contentLength >= pow(1024, 3)) { return (float) (contentLength / (float)pow(1024, 3)); }
    else if (contentLength >= pow(1024, 2)) { return (float) (contentLength / (float)pow(1024, 2)); }
    else if (contentLength >= 1024) { return (float) (contentLength / (float)1024); }
    else { return (float) (contentLength); }
}

/**
 task的urlString
 
 @param task 任务
 @return urlString
 */
- (NSString *)getUrlStringWithTaskResponse:(NSURLSessionTask *)task {
    return [task.response.URL absoluteString];
}

//开始下一个任务
-(void)startNextDownloadTask{
    if (self.performWaitArr.count==0) {
        return;
    }
    if (self.performWaitArr.count>0) {
        LGHSession *session = self.performWaitArr.firstObject;
        if (session && session.dataTask) {
            // 如果确认可以开始下载
            if ([self isStartDownloadWithSession:session]) {
                [self.performWaitArr removeObjectAtIndex:0];
            }
        }
    }
}

/**
 添加信息到本地
 @param session 信息
 */
- (void)addSession:(LGHSession *)session {
    [self.downloadingArr addObject:@{session.url:session}];
    [self saveSessions];
}

/**
 开始任务或者等待开始

 @return 是否立即开始任务
 */
- (BOOL)isStartDownloadWithSession:(LGHSession*)session{
    if (self.maximumConnections == 10000) {
        [self.performingArr addObject:session];
        return YES;
    }
    if (self.performingArr.count<self.maximumConnections) {
        [self addObjectWith:self.performingArr session:session];
        session.downloadState = LGHDownloadStateLoading;
        if (session.stateBlock) session.stateBlock(LGHDownloadStateLoading);
        return YES;
    }else{
        session.downloadState = LGHDownloadStateWaiting;
        if (session.stateBlock) session.stateBlock(LGHDownloadStateWaiting);
        [self addObjectWith:self.performWaitArr session:session];;
        return NO;
    }
}

/**
 数组中删除任务

 @param array 数组
 */
- (void)removeObjectWith:(NSMutableArray <LGHSession *>*)array session:(LGHSession *)session {
    for (LGHSession *eachSession in array.reverseObjectEnumerator) {
        if (eachSession.url == session.url) {
            [array removeObject:eachSession];
        }
    }
}

/**
 数组中添加任务
 @param array 数组
 */
- (void)addObjectWith:(NSMutableArray *)array session:(LGHSession *)session {
    for (LGHSession *eachSession in array) {
        if (eachSession.url == session.url) {
            return;
        }
    }
    [array addObject:session];
}

/**
 * 存储信息
 */
- (void)saveSessions
{
    self.allDownloadArr = @[self.downloadedArr, self.downloadingArr];
    [NSKeyedArchiver archiveRootObject:self.allDownloadArr toFile:LGHDownloadDetailPath];
}

/**
 * 读取所有的下载信息
 */
- (NSArray *)getAllSessions
{
    // 文件信息
    NSArray *downloadArr = [NSKeyedUnarchiver unarchiveObjectWithFile:LGHDownloadDetailPath];
    return downloadArr;
}


/**
 // ********非常重要********
 配置任务
 @param url 任务地址
 @return @[NSURLSessionDataTask, session]
 */
- (NSArray *)resumeURLSession:(NSString *)url {
    // session配置
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration backgroundSessionConfigurationWithIdentifier:url];
    // 得到session对象
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    // 创建流
    NSOutputStream *stream = [NSOutputStream outputStreamToFileAtPath:LGHFileFullpath(url) append:YES];
    // 创建请求
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    // 设置请求头
    NSString *range = [NSString stringWithFormat:@"bytes=%zd-", LGHDownloadLength(url)];
    [request setValue:range forHTTPHeaderField:@"Range"];
    // 创建一个Data任务
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request];
    return @[dataTask, stream];
}

/**
 判断当前url是否可以下载
 @param url 下载url
 @return 任务状态
 */

-(LGHDownloadTaskState)checkCanDownload:(NSString *)urlString{
    if (!urlString) {
        return LGHDownloadTaskStateUrlNil;
    }
    if (![self isRightUrlSting:urlString]) {
        return LGHDownloadTaskStateUrlRrror;
    }
    LGHSession *session =  [self getDownloadSessionWithUrlString:urlString];
    if (!session) {
        return LGHDownloadTaskStateCanDownload;
    }
    switch (session.downloadState) {
        case LGHDownloadStateWaiting:
            return LGHDownloadTaskStateWaiting;
        case LGHDownloadStateLoading:
            return LGHDownloadTaskStateLoading;
        case LGHDownloadStatePause:
            return LGHDownloadTaskStatePause;
        case LGHDownloadStateFailed:
            return LGHDownloadTaskStateFailed;
        case LGHDownloadStateCompleted:
            return LGHDownloadTaskStateCompleted;
        default:
            return LGHDownloadTaskStateNoTask;
    }
}


/**
 匹配正确网址
 
 @param string 需要验证的字符串
 @return 是否是正确网址
 */
- (BOOL)isRightUrlSting:(NSString *)string {
    
    NSString *regex = @"\\bhttps?://[a-zA-Z0-9\\-.]+(?::(\\d+))?(?:(?:/[a-zA-Z0-9\\-._?,'+\\&%$=~*!():@\\\\]*)+)?";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:string];
}


#pragma mark - dealloc

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}


@end
