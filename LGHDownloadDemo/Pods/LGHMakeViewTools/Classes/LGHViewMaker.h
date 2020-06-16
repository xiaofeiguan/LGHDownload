//
//  LGHViewMaker.h
//  Test
//
//  Created by gamesirDev on 8/7/2019.
//  Copyright © 2019 gamesirDev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LGHViewMaker : NSObject

/// clipsToBounds
@property (nonatomic, copy, readonly) LGHViewMaker* (^clipsToBounds)(BOOL flag);
/// 父View
@property (nonatomic, copy, readonly) LGHViewMaker* (^addTo)(UIView* superview);
/// frame
@property (nonatomic, copy, readonly) LGHViewMaker* (^frame)(CGRect frame);
/// bounds
@property (nonatomic, copy, readonly) LGHViewMaker* (^bounds)(CGRect bounds);
/// center
@property (nonatomic, copy, readonly) LGHViewMaker* (^center)(CGPoint center);
/// 背景颜色
@property (nonatomic, copy, readonly) LGHViewMaker* (^backgroundColor)(UIColor* color);
/// 是否隐藏
@property (nonatomic, copy, readonly) LGHViewMaker* (^hidden)(BOOL flag);
/// 标签
@property (nonatomic, copy, readonly) LGHViewMaker* (^tag)(NSInteger tag);
/// 可交互性
@property (nonatomic, copy, readonly) LGHViewMaker* (^userInteractionEnabled)(BOOL flag);
/// layer.cornerRadius
@property (nonatomic, copy, readonly) LGHViewMaker* (^layerCornerRadius)(CGFloat radius);
/// layer.maskToBounds
@property (nonatomic, copy, readonly) LGHViewMaker* (^layerMaskToBounds)(BOOL flag);
/// layer.borderWidth：边框宽度
@property (nonatomic, copy, readonly) LGHViewMaker* (^layerBorderWidth)(CGFloat width);
/// layer.borderColor：边框颜色，传入UIColor值
@property (nonatomic, copy, readonly) LGHViewMaker* (^layerBorderColor)(UIColor* color);
/// tintColor
@property (nonatomic, copy, readonly) LGHViewMaker* (^tintColor)(UIColor* color);
/// alpha
@property (nonatomic, copy, readonly) LGHViewMaker* (^alpha)(CGFloat alpha);
/// contentMode
@property (nonatomic, copy, readonly) LGHViewMaker* (^contentMode)(UIViewContentMode mode);
@end

@interface UIView (LGHMaker)
/// 链式创建UIView
+ (instancetype)LGH_make:(void(^)(LGHViewMaker* make))make;
@end
