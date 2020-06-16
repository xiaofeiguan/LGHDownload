//
//  LGHTableViewMaker.h
//  Test
//
//  Created by gamesirDev on 9/7/2019.
//  Copyright © 2019 gamesirDev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LGHTableViewMaker : NSObject
/// 代理
@property (nonatomic, copy, readonly) LGHTableViewMaker* (^delegate)(id object);
/// 数据源
@property (nonatomic, copy, readonly) LGHTableViewMaker* (^dataSource)(id object);
/// 注册cell，Identifier是类名
@property (nonatomic, copy, readonly) LGHTableViewMaker* (^registerClass)(Class aClass);
/// 注册cell，Identifier是类名
@property (nonatomic, copy, readonly) LGHTableViewMaker* (^registerNib)(UINib *aNib, NSString* identify);
/// 分割线样式
@property (nonatomic, copy, readonly) LGHTableViewMaker* (^separatorStyle)(UITableViewCellSeparatorStyle style);
/// 分割线颜色
@property (nonatomic, copy, readonly) LGHTableViewMaker* (^separatorColor)(UIColor* color);
/// 分割线缩进
@property (nonatomic, copy, readonly) LGHTableViewMaker* (^separatorInset)(UIEdgeInsets insets);
/// 底部View
@property (nonatomic, copy, readonly) LGHTableViewMaker* (^tableFooterView)(UIView* view);
/// 预估高度
@property (nonatomic, copy, readonly) LGHTableViewMaker* (^estimatedRowHeight)(CGFloat height);

#pragma mark - UIView公共属性

/// clipsToBounds
@property (nonatomic, copy, readonly) LGHTableViewMaker* (^clipsToBounds)(BOOL flag);
/// 父View
@property (nonatomic, copy, readonly) LGHTableViewMaker* (^addTo)(UIView* superview);
/// frame
@property (nonatomic, copy, readonly) LGHTableViewMaker* (^frame)(CGRect frame);
/// bounds
@property (nonatomic, copy, readonly) LGHTableViewMaker* (^bounds)(CGRect bounds);
/// center
@property (nonatomic, copy, readonly) LGHTableViewMaker* (^center)(CGPoint center);
/// 背景颜色
@property (nonatomic, copy, readonly) LGHTableViewMaker* (^backgroundColor)(UIColor* color);
/// 是否隐藏
@property (nonatomic, copy, readonly) LGHTableViewMaker* (^hidden)(BOOL flag);
/// 标签
@property (nonatomic, copy, readonly) LGHTableViewMaker* (^tag)(NSInteger tag);
/// 可交互性
@property (nonatomic, copy, readonly) LGHTableViewMaker* (^userInteractionEnabled)(BOOL flag);
/// layer.cornerRadius
@property (nonatomic, copy, readonly) LGHTableViewMaker* (^layerCornerRadius)(CGFloat radius);
/// layer.maskToBounds
@property (nonatomic, copy, readonly) LGHTableViewMaker* (^layerMaskToBounds)(BOOL flag);
/// layer.borderWidth：边框宽度
@property (nonatomic, copy, readonly) LGHTableViewMaker* (^layerBorderWidth)(CGFloat width);
/// layer.borderColor：边框颜色，传入UIColor值
@property (nonatomic, copy, readonly) LGHTableViewMaker* (^layerBorderColor)(UIColor* color);
/// tintColor
@property (nonatomic, copy, readonly) LGHTableViewMaker* (^tintColor)(UIColor* color);
/// alpha
@property (nonatomic, copy, readonly) LGHTableViewMaker* (^alpha)(CGFloat alpha);
/// contentMode
@property (nonatomic, copy, readonly) LGHTableViewMaker* (^contentMode)(UIViewContentMode mode);
@end


@interface UITableView (LGHMaker)
/// 链式创建UITableView
+ (instancetype)LGH_make:(void(^)(LGHTableViewMaker* make))make style:(UITableViewStyle)style;
@end
