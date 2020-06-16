//
//  LGHListViewController.m
//  DownLoad
//
//  Created by 小肥观 on 2020/6/15.
//  Copyright © 2020 share. All rights reserved.
//

#import "LGHListViewController.h"
#import "LGHDwonloadTaskController.h"
#import "Masonry.h"
#import "LGHDownloadManager.h"
#import "SVProgressHUD.h"
#import "LGHViewMakerHeader.h"

@interface LGHListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, copy) NSMutableArray * videoUrls;
@property (nonatomic, strong) UITableView * mainTableView;

@property (nonatomic, strong) LGHDownloadManager * manager;


@end

@implementation LGHListViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.manager = [LGHDownloadManager sharedInstance];
    self.videoUrls = [
                       @[@"http://113.105.248.47/7/k/q/c/h/kqchypojfvorzsswimdqqzkelhnpit/sh.yinyuetai.com/2C3E015F0AF6935955FC8F573886BF91.mp4",
                         @"http://113.105.248.47/7/f/t/b/d/ftbdorjlxonsomhzbdeagxbdiejoxn/sh.yinyuetai.com/DF96015F37841A8D6CA34A7EA49909EB.mp4",
                         @"http://183.60.197.26/7/y/j/t/f/yjtfwhmpiwmakuwpudcbnlcskeqzic/hd.yinyuetai.com/3CDD015EA41F2043C31390354BC1DE51.mp4"
                       ] mutableCopy];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"下载页" style:UIBarButtonItemStylePlain target:self action:@selector(intoDownloadVC)];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.mainTableView = [UITableView LGH_make:^(LGHTableViewMaker *make) {
        make.addTo(self.view)
        .frame(self.view.bounds)
        .dataSource(self)
        .delegate(self);
    } style:UITableViewStylePlain];
    [self.mainTableView reloadData];
    
}

-(void)intoDownloadVC{
    LGHDwonloadTaskController *vc = [[LGHDwonloadTaskController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UITableViewDelegate/UITableViewDatasource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.videoUrls.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([UITableViewCell class])];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%ld.mp4",indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *url = self.videoUrls[indexPath.row];
    LGHDownloadState state =  [self.manager download:url progress:nil state:nil];
    switch (state) {
        case LGHDownloadTaskStateUrlNil:{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"下载地址错误" message:@"" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
        }
            break;
        case LGHDownloadTaskStateUrlRrror:{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"下载地址错误" message:@"" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
        }
            break;
        case LGHDownloadTaskStateCompleted:{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"此任务已下载完成" message:@"" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
        }
            break;
        case LGHDownloadTaskStateCanDownload:{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"添加到下载列表" message:@"" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
        }
            break;
            
        default:{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"列表中已有该任务" message:@"" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
        }
            break;
    }
}



@end
