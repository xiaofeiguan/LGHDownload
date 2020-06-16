//
//  LGHImageViewMaker.h
//  Test
//
//  Created by gamesirDev on 9/7/2019.
//  Copyright © 2019 gamesirDev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LGHImageViewMaker : NSObject

/// 图片
@property (nonatomic, copy, readonly) LGHImageViewMaker* (^image)(UIImage* image);
/// 图片名称
@property (nonatomic, copy, readonly) LGHImageViewMaker* (^imageName)(NSString* imageName);

#pragma mark - UIView公共属性

/// clipsToBounds
@property (nonatomic, copy, readonly) LGHImageViewMaker* (^clipsToBounds)(BOOL flag);
/// 父View
@property (nonatomic, copy, readonly) LGHImageViewMaker* (^addTo)(UIView* superview);
/// frame
@property (nonatomic, copy, readonly) LGHImageViewMaker* (^frame)(CGRect frame);
/// bounds
@property (nonatomic, copy, readonly) LGHImageViewMaker* (^bounds)(CGRect bounds);
/// center
@property (nonatomic, copy, readonly) LGHImageViewMaker* (^center)(CGPoint center);
/// 背景颜色
@property (nonatomic, copy, readonly) LGHImageViewMaker* (^backgroundColor)(UIColor* color);
/// 是否隐藏
@property (nonatomic, copy, readonly) LGHImageViewMaker* (^hidden)(BOOL flag);
/// 标签
@property (nonatomic, copy, readonly) LGHImageViewMaker* (^tag)(NSInteger tag);
/// 可交互性
@property (nonatomic, copy, readonly) LGHImageViewMaker* (^userInteractionEnabled)(BOOL flag);
/// layer.cornerRadius
@property (nonatomic, copy, readonly) LGHImageViewMaker* (^layerCornerRadius)(CGFloat radius);
/// layer.maskToBounds
@property (nonatomic, copy, readonly) LGHImageViewMaker* (^layerMaskToBounds)(BOOL flag);
/// layer.borderWidth：边框宽度
@property (nonatomic, copy, readonly) LGHImageViewMaker* (^layerBorderWidth)(CGFloat width);
/// layer.borderColor：边框颜色，传入UIColor值
@property (nonatomic, copy, readonly) LGHImageViewMaker* (^layerBorderColor)(UIColor* color);
/// tintColor
@property (nonatomic, copy, readonly) LGHImageViewMaker* (^tintColor)(UIColor* color);
/// alpha
@property (nonatomic, copy, readonly) LGHImageViewMaker* (^alpha)(CGFloat alpha);
/// contentMode
@property (nonatomic, copy, readonly) LGHImageViewMaker* (^contentMode)(UIViewContentMode mode);
@end


@interface UIImageView (LGHMaker)
/// 链式创建UIImageView
+ (instancetype)LGH_make:(void(^)(LGHImageViewMaker* make))make;
@end
