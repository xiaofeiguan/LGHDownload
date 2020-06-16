//
//  LGHButtonMaker.h
//  Test
//
//  Created by gamesirDev on 9/7/2019.
//  Copyright © 2019 gamesirDev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^LGHButtonMakerActionBlock)(UIButton *button);

@interface LGHButtonMaker : NSObject

/// 标题
@property (nonatomic, copy, readonly) LGHButtonMaker* (^title)(NSString* title, UIControlState state);
/// 标题颜色
@property (nonatomic, copy, readonly) LGHButtonMaker* (^titleColor)(UIColor* color, UIControlState state);
/// 标题字体
@property (nonatomic, copy, readonly) LGHButtonMaker* (^titleFont)(UIFont* font);
/// 选择状态
@property (nonatomic, copy, readonly) LGHButtonMaker* (^selected)(BOOL flag);
/// 图片
@property (nonatomic, copy, readonly) LGHButtonMaker* (^image)(UIImage* image, UIControlState state);
/// 图片名称
@property (nonatomic, copy, readonly) LGHButtonMaker* (^backgroundImage)(UIImage* image, UIControlState state);
/// 富文本
@property (nonatomic, copy, readonly) LGHButtonMaker* (^attributedString)(NSString* title, UIColor* color, UIFont* font, UIControlState state);
/// touchUpInside点击事件
@property (nonatomic, copy, readonly) LGHButtonMaker* (^action)(LGHButtonMakerActionBlock block);
/// 点击事件
@property (nonatomic, copy, readonly) LGHButtonMaker* (^actionWithEvents)(LGHButtonMakerActionBlock block, UIControlEvents events);
/// 处于highlighted状态时调整图片
@property (nonatomic, copy, readonly) LGHButtonMaker* (^adjustsImageWhenHighlighted)(BOOL flag);


#pragma mark - UIView公共属性

/// clipsToBounds
@property (nonatomic, copy, readonly) LGHButtonMaker* (^clipsToBounds)(BOOL flag);
/// 父View
@property (nonatomic, copy, readonly) LGHButtonMaker* (^addTo)(UIView* superview);
/// frame
@property (nonatomic, copy, readonly) LGHButtonMaker* (^frame)(CGRect frame);
/// bounds
@property (nonatomic, copy, readonly) LGHButtonMaker* (^bounds)(CGRect bounds);
/// center
@property (nonatomic, copy, readonly) LGHButtonMaker* (^center)(CGPoint center);
/// 背景颜色
@property (nonatomic, copy, readonly) LGHButtonMaker* (^backgroundColor)(UIColor* color);
/// 是否隐藏
@property (nonatomic, copy, readonly) LGHButtonMaker* (^hidden)(BOOL flag);
/// 标签
@property (nonatomic, copy, readonly) LGHButtonMaker* (^tag)(NSInteger tag);
/// 可交互性
@property (nonatomic, copy, readonly) LGHButtonMaker* (^userInteractionEnabled)(BOOL flag);
/// layer.cornerRadius
@property (nonatomic, copy, readonly) LGHButtonMaker* (^layerCornerRadius)(CGFloat radius);
/// layer.maskToBounds
@property (nonatomic, copy, readonly) LGHButtonMaker* (^layerMaskToBounds)(BOOL flag);
/// layer.borderWidth：边框宽度
@property (nonatomic, copy, readonly) LGHButtonMaker* (^layerBorderWidth)(CGFloat width);
/// layer.borderColor：边框颜色，传入UIColor值
@property (nonatomic, copy, readonly) LGHButtonMaker* (^layerBorderColor)(UIColor* color);
/// tintColor
@property (nonatomic, copy, readonly) LGHButtonMaker* (^tintColor)(UIColor* color);
/// alpha
@property (nonatomic, copy, readonly) LGHButtonMaker* (^alpha)(CGFloat alpha);
/// contentMode
@property (nonatomic, copy, readonly) LGHButtonMaker* (^contentMode)(UIViewContentMode mode);
@end


@interface UIButton (LGHMaker)
/// 链式创建UIButton
+ (instancetype)LGH_make:(void(^)(LGHButtonMaker* make))make;
- (instancetype)LGH_make:(void(^)(LGHButtonMaker* make))make;

@end
