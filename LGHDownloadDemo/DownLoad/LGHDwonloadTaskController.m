//
//  LGHDwonloadTaskController.m
//  DownLoad
//
//  Created by 小肥观 on 2020/6/16.
//  Copyright © 2020 share. All rights reserved.
//

#import "LGHDwonloadTaskController.h"
#import "LGHDownloadManager.h"
#import "VideoTableViewCell.h"
@interface LGHDwonloadTaskController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView * mainTableView;
@property (nonatomic, strong) LGHDownloadManager * manager;
@end

@implementation LGHDwonloadTaskController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.manager = [LGHDownloadManager sharedInstance];
    self.mainTableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    [self.view addSubview:self.mainTableView];
    [self.mainTableView reloadData];
}


-(void)updateDatas{
    [self.mainTableView reloadData];
}

#pragma mark - UITableViewDelegate/UITableViewDatasource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return self.manager.getDownloadedArr.count;
    }else {
        return self.manager.getDownloadingArr.count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    VideoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VideoTableViewCellIdentify"];
    
    if (!cell) {
        cell = (VideoTableViewCell*)[[UINib nibWithNibName:@"VideoTableViewCell" bundle:nil]instantiateWithOwner:self options:nil].firstObject;
    }
    
    LGHSession *session = nil;
    if (indexPath.section == 0) {
        session = self.manager.getDownloadedArr[indexPath.row];
        
    }else{
        session = self.manager.getDownloadingArr[indexPath.row];
    }
    
    cell.titleLabel.text = [session.url  substringFromIndex:session.url.length-10];
    cell.speedLabel.text = @"";
    cell.progressLabel.text = [NSString stringWithFormat:@"%@/%@",session.totalBytesWritten,session.totalSize];
    cell.progressView.progress = session.progress;
    LGHDownloadState state = session.downloadState;
    switch (state) {
        case LGHDownloadStatePause:
            cell.stateLabel.text = @"Suspend";
            break;
        case LGHDownloadStateLoading:
            cell.stateLabel.text = @"Downloading";
            break;
        case LGHDownloadStateFailed:
            cell.speedLabel.text = @"";
            cell.stateLabel.text = @"Failed";
            break;
        case LGHDownloadStateWaiting:
            cell.stateLabel.text = @"Waiting";
            break;
        case LGHDownloadStateCompleted:
            cell.stateLabel.text = @"Completed";
            break;
        default:
            break;
    }
    
    session.stateBlock = ^(LGHDownloadState state) {
        dispatch_async(dispatch_get_main_queue(), ^{
            switch (state) {
                case LGHDownloadStatePause:
                    cell.stateLabel.text = @"Suspend";
                    break;
                case LGHDownloadStateLoading:
                    cell.stateLabel.text = @"Downloading";
                    break;
                case LGHDownloadStateFailed:
                    cell.speedLabel.text = @"";
                    cell.stateLabel.text = @"Failed";
                    break;
                case LGHDownloadStateWaiting:
                    cell.stateLabel.text = @"Waiting";
                    break;
                case LGHDownloadStateCompleted:
                    cell.stateLabel.text = @"Completed";
                    [self updateDatas];
                    break;
                default:
                    break;
            }
        });
    };
    
    session.downloadingBlock = ^(CGFloat progress, NSString * _Nonnull speed, NSString * _Nonnull remianingTime, NSString * _Nonnull writtenSize, NSString * _Nonnull totalSize) {
        dispatch_async(dispatch_get_main_queue(), ^{
            cell.progressView.progress = progress;
            cell.speedLabel.text = speed;
            cell.progressLabel.text = [NSString stringWithFormat:@"%@/%@",writtenSize,totalSize];
        });
    };
    return cell;
}




-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section==1) {
        LGHSession *session = self.manager.getDownloadingArr[indexPath.row];
        switch (session.downloadState) {
            case LGHDownloadStatePause:
                [self.manager resumeDownload:session.url];
                break;
            case LGHDownloadStateLoading:
                [self.manager pauseDownloadTaskWithUrl:session.url];
                break;
            case LGHDownloadStateFailed:
                [self.manager resumeDownload:session.url];
                break;
            case LGHDownloadStateWaiting:
                [self.manager resumeDownload:session.url];
                break;
            default:
                break;
        }
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 115;
}

@end
