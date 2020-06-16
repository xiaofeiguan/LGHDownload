//
//  VideoTableViewCell.h
//  DownLoad
//
//  Created by 小肥观 on 2020/6/16.
//  Copyright © 2020 share. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface VideoTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *speedLabel;

@property (weak, nonatomic) IBOutlet UILabel *progressLabel;

@property (weak, nonatomic) IBOutlet UILabel *stateLabel;

@property (weak, nonatomic) IBOutlet UIProgressView *progressView;

@end

NS_ASSUME_NONNULL_END
