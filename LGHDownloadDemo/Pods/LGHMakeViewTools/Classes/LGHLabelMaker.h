//
//  LGHLabelMaker.h
//  Test
//
//  Created by gamesirDev on 9/7/2019.
//  Copyright © 2019 gamesirDev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LGHLabelMaker : NSObject

/// 文本
@property (nonatomic, copy, readonly) LGHLabelMaker* (^text)(NSString* string);
/// 文本颜色
@property (nonatomic, copy, readonly) LGHLabelMaker* (^textColor)(UIColor* color);
/// 字体
@property (nonatomic, copy, readonly) LGHLabelMaker* (^font)(UIFont* font);
/// 富文本
@property (nonatomic, copy, readonly) LGHLabelMaker* (^attributedText)(NSAttributedString* atbString);
/// 文本对齐方式
@property (nonatomic, copy, readonly) LGHLabelMaker* (^textAlignment)(NSTextAlignment alignment);
/// 文本行数
@property (nonatomic, copy, readonly) LGHLabelMaker* (^numberOfLines)(NSInteger lines);
/// 未显示文字(...)的展示位置
@property (nonatomic, copy, readonly) LGHLabelMaker* (^lineBreakMode)(NSLineBreakMode mode);

/* 每个子类都加上UIView的公共属性，是为了实现下面这种写法
 *   make.xxx()
 *   .yyy()
 *   .zzz()
 */
#pragma mark - UIView公共属性

/// clipsToBounds
@property (nonatomic, copy, readonly) LGHLabelMaker* (^clipsToBounds)(BOOL flag);
/// 父View
@property (nonatomic, copy, readonly) LGHLabelMaker* (^addTo)(UIView* superview);
/// frame
@property (nonatomic, copy, readonly) LGHLabelMaker* (^frame)(CGRect frame);
/// bounds
@property (nonatomic, copy, readonly) LGHLabelMaker* (^bounds)(CGRect bounds);
/// center
@property (nonatomic, copy, readonly) LGHLabelMaker* (^center)(CGPoint center);
/// 背景颜色
@property (nonatomic, copy, readonly) LGHLabelMaker* (^backgroundColor)(UIColor* color);
/// 是否隐藏
@property (nonatomic, copy, readonly) LGHLabelMaker* (^hidden)(BOOL flag);
/// 标签
@property (nonatomic, copy, readonly) LGHLabelMaker* (^tag)(NSInteger tag);
/// 可交互性
@property (nonatomic, copy, readonly) LGHLabelMaker* (^userInteractionEnabled)(BOOL flag);
/// layer.cornerRadius
@property (nonatomic, copy, readonly) LGHLabelMaker* (^layerCornerRadius)(CGFloat radius);
/// layer.maskToBounds
@property (nonatomic, copy, readonly) LGHLabelMaker* (^layerMaskToBounds)(BOOL flag);
/// layer.borderWidth：边框宽度
@property (nonatomic, copy, readonly) LGHLabelMaker* (^layerBorderWidth)(CGFloat width);
/// layer.borderColor：边框颜色，传入UIColor值
@property (nonatomic, copy, readonly) LGHLabelMaker* (^layerBorderColor)(UIColor* color);
/// tintColor
@property (nonatomic, copy, readonly) LGHLabelMaker* (^tintColor)(UIColor* color);
/// alpha
@property (nonatomic, copy, readonly) LGHLabelMaker* (^alpha)(CGFloat alpha);
/// contentMode
@property (nonatomic, copy, readonly) LGHLabelMaker* (^contentMode)(UIViewContentMode mode);
@end


@interface UILabel (LGHMaker)
/// 链式创建UILabel
+ (instancetype)LGH_make:(void(^)(LGHLabelMaker* make))make;
@end
