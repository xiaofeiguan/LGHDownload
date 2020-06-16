//
//  LGHTextViewMaker.h
//  Animation
//
//  Created by gamesirDev on 26/12/2019.
//  Copyright © 2019 Lfm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LGHTextViewMaker : NSObject
/// 代理
@property (nonatomic, copy, readonly) LGHTextViewMaker* (^delegate)(id object);
/// 文本
@property (nonatomic, copy, readonly) LGHTextViewMaker* (^text)(NSString* string);
/// 文本颜色
@property (nonatomic, copy, readonly) LGHTextViewMaker* (^textColor)(UIColor* color);
/// 字体
@property (nonatomic, copy, readonly) LGHTextViewMaker* (^font)(UIFont* font);
/// 占位符
@property (nonatomic, copy, readonly) LGHTextViewMaker* (^placeholder)(UILabel* label);
/// 占位符字体颜色
@property (nonatomic, copy, readonly) LGHTextViewMaker* (^placeholderColor)(UIColor* color);
/// 富文本
@property (nonatomic, copy, readonly) LGHTextViewMaker* (^attributedText)(NSAttributedString* atbString);
/// 文本对齐方式
@property (nonatomic, copy, readonly) LGHTextViewMaker* (^textAlignment)(NSTextAlignment alignment);
/// 安全输入
@property (nonatomic, copy, readonly) LGHTextViewMaker* (^secureTextEntry)(BOOL flag);

#pragma mark - UIView公共属性

/// clipsToBounds
@property (nonatomic, copy, readonly) LGHTextViewMaker* (^clipsToBounds)(BOOL flag);
/// 父View
@property (nonatomic, copy, readonly) LGHTextViewMaker* (^addTo)(UIView* superview);
/// frame
@property (nonatomic, copy, readonly) LGHTextViewMaker* (^frame)(CGRect frame);
/// bounds
@property (nonatomic, copy, readonly) LGHTextViewMaker* (^bounds)(CGRect bounds);
/// center
@property (nonatomic, copy, readonly) LGHTextViewMaker* (^center)(CGPoint center);
/// 背景颜色
@property (nonatomic, copy, readonly) LGHTextViewMaker* (^backgroundColor)(UIColor* color);
/// 是否隐藏
@property (nonatomic, copy, readonly) LGHTextViewMaker* (^hidden)(BOOL flag);
/// 标签
@property (nonatomic, copy, readonly) LGHTextViewMaker* (^tag)(NSInteger tag);
/// 可交互性
@property (nonatomic, copy, readonly) LGHTextViewMaker* (^userInteractionEnabled)(BOOL flag);
/// layer.cornerRadius
@property (nonatomic, copy, readonly) LGHTextViewMaker* (^layerCornerRadius)(CGFloat radius);
/// layer.maskToBounds
@property (nonatomic, copy, readonly) LGHTextViewMaker* (^layerMaskToBounds)(BOOL flag);
/// layer.borderWidth：边框宽度
@property (nonatomic, copy, readonly) LGHTextViewMaker* (^layerBorderWidth)(CGFloat width);
/// layer.borderColor：边框颜色，传入UIColor值
@property (nonatomic, copy, readonly) LGHTextViewMaker* (^layerBorderColor)(UIColor* color);
/// tintColor
@property (nonatomic, copy, readonly) LGHTextViewMaker* (^tintColor)(UIColor* color);
/// alpha
@property (nonatomic, copy, readonly) LGHTextViewMaker* (^alpha)(CGFloat alpha);
/// contentMode
@property (nonatomic, copy, readonly) LGHTextViewMaker* (^contentMode)(UIViewContentMode mode);
@end

NS_ASSUME_NONNULL_END

@interface UITextView (LGHMaker)
/// 链式创建UITextView
+ (instancetype)LGH_make:(void(^)(LGHTextViewMaker* make))make;
@end
