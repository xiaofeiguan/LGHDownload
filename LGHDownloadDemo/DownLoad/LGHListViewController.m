//
//  LGHListViewController.m
//  DownLoad
//
//  Created by 小肥观 on 2020/6/15.
//  Copyright © 2020 share. All rights reserved.
//

#import "LGHListViewController.h"
@interface LGHListViewController ()

@property (nonatomic, strong) UITableView * mainTableView;

@end

@implementation LGHListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.mainTableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    self.mainTableView 
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
