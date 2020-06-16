//
//  LGHTextFieldMaker.h
//  Test
//
//  Created by gamesirDev on 12/7/2019.
//  Copyright © 2019 gamesirDev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LGHTextFieldMaker : NSObject

/// 代理
@property (nonatomic, copy, readonly) LGHTextFieldMaker* (^delegate)(id object);
/// 文本
@property (nonatomic, copy, readonly) LGHTextFieldMaker* (^text)(NSString* string);
/// 文本颜色
@property (nonatomic, copy, readonly) LGHTextFieldMaker* (^textColor)(UIColor* color);
/// 字体
@property (nonatomic, copy, readonly) LGHTextFieldMaker* (^font)(UIFont* font);
/// 占位符
@property (nonatomic, copy, readonly) LGHTextFieldMaker* (^placeholder)(NSString* string);
/// 占位符字体颜色
@property (nonatomic, copy, readonly) LGHTextFieldMaker* (^placeholderColor)(UIColor* color);
/// 富文本
@property (nonatomic, copy, readonly) LGHTextFieldMaker* (^attributedText)(NSAttributedString* atbString);
/// 文本对齐方式
@property (nonatomic, copy, readonly) LGHTextFieldMaker* (^textAlignment)(NSTextAlignment alignment);
/// 开始编辑的时候清空文本
@property (nonatomic, copy, readonly) LGHTextFieldMaker* (^clearsOnBeginEditing)(BOOL flag);
/// 清空按钮的模式
@property (nonatomic, copy, readonly) LGHTextFieldMaker* (^clearButtonMode)(UITextFieldViewMode mode);
/// 左侧View
@property (nonatomic, copy, readonly) LGHTextFieldMaker* (^leftView)(UIView* view);
/// 左侧View的模式
@property (nonatomic, copy, readonly) LGHTextFieldMaker* (^leftViewMode)(UITextFieldViewMode mode);
/// border风格
@property (nonatomic, copy, readonly) LGHTextFieldMaker* (^borderStyle)(UITextBorderStyle style);
/// 安全输入
@property (nonatomic, copy, readonly) LGHTextFieldMaker* (^secureTextEntry)(BOOL flag);

#pragma mark - UIView公共属性

/// clipsToBounds
@property (nonatomic, copy, readonly) LGHTextFieldMaker* (^clipsToBounds)(BOOL flag);
/// 父View
@property (nonatomic, copy, readonly) LGHTextFieldMaker* (^addTo)(UIView* superview);
/// frame
@property (nonatomic, copy, readonly) LGHTextFieldMaker* (^frame)(CGRect frame);
/// bounds
@property (nonatomic, copy, readonly) LGHTextFieldMaker* (^bounds)(CGRect bounds);
/// center
@property (nonatomic, copy, readonly) LGHTextFieldMaker* (^center)(CGPoint center);
/// 背景颜色
@property (nonatomic, copy, readonly) LGHTextFieldMaker* (^backgroundColor)(UIColor* color);
/// 是否隐藏
@property (nonatomic, copy, readonly) LGHTextFieldMaker* (^hidden)(BOOL flag);
/// 标签
@property (nonatomic, copy, readonly) LGHTextFieldMaker* (^tag)(NSInteger tag);
/// 可交互性
@property (nonatomic, copy, readonly) LGHTextFieldMaker* (^userInteractionEnabled)(BOOL flag);
/// layer.cornerRadius
@property (nonatomic, copy, readonly) LGHTextFieldMaker* (^layerCornerRadius)(CGFloat radius);
/// layer.maskToBounds
@property (nonatomic, copy, readonly) LGHTextFieldMaker* (^layerMaskToBounds)(BOOL flag);
/// layer.borderWidth：边框宽度
@property (nonatomic, copy, readonly) LGHTextFieldMaker* (^layerBorderWidth)(CGFloat width);
/// layer.borderColor：边框颜色，传入UIColor值
@property (nonatomic, copy, readonly) LGHTextFieldMaker* (^layerBorderColor)(UIColor* color);
/// tintColor
@property (nonatomic, copy, readonly) LGHTextFieldMaker* (^tintColor)(UIColor* color);
/// alpha
@property (nonatomic, copy, readonly) LGHTextFieldMaker* (^alpha)(CGFloat alpha);
/// contentMode
@property (nonatomic, copy, readonly) LGHTextFieldMaker* (^contentMode)(UIViewContentMode mode);
@end

NS_ASSUME_NONNULL_END


@interface UITextField (LGHMaker)
/// 链式创建UITextField
+ (instancetype)LGH_make:(void(^)(LGHTextFieldMaker* make))make;
@end
