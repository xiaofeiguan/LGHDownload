//
//  LGHButtonMaker.m
//  Test
//
//  Created by gamesirDev on 9/7/2019.
//  Copyright © 2019 gamesirDev. All rights reserved.
//

#import "LGHButtonMaker.h"
#import <objc/message.h>

@interface LGHButtonMaker ()
@property (nonatomic, retain, readwrite) UIButton*           button;
@end

@implementation LGHButtonMaker

- (instancetype)initView {
    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    return self;
}


/// Title
- (LGHButtonMaker* (^)(NSString *, UIControlState))title {
    /// 数据由括号内传来的值决定
    return ^LGHButtonMaker* (NSString* title, UIControlState state) {
        [self.button setTitle:title forState:state];
        
        return self;
    };
}

/// TitleColor
- (LGHButtonMaker* (^)(UIColor *, UIControlState))titleColor {
    return ^LGHButtonMaker* (UIColor* color, UIControlState state) {
        [self.button setTitleColor:color forState:state];
        
        return self;
    };
}

/// Font
- (LGHButtonMaker *(^)(UIFont *))titleFont {
    return ^LGHButtonMaker* (UIFont* font) {
        self.button.titleLabel.font = font;
        
        return self;
    };
}

/// Selected
- (LGHButtonMaker *(^)(BOOL))selected {
    return ^LGHButtonMaker* (BOOL flag) {
        self.button.selected = flag;
        
        return self;
    };
}

/// Image
- (LGHButtonMaker* (^)(UIImage *, UIControlState))image {
    return ^LGHButtonMaker* (UIImage* image, UIControlState state) {
        [self.button setImage:image forState:state];
        
        return self;
    };
}

- (LGHButtonMaker* (^)(UIImage *, UIControlState))backgroundImage {
    return ^LGHButtonMaker* (UIImage* image, UIControlState state) {
        [self.button setBackgroundImage:image forState:state];
        
        return self;
    };
}

/// AttributedString
- (LGHButtonMaker* (^)(NSString *, UIColor *, UIFont *, UIControlState))attributedString {
    return ^LGHButtonMaker* (NSString* title, UIColor* color, UIFont *font, UIControlState state) {
        NSAssert(title.length > 0, @"设置attributedString的标题不能为空");
        NSMutableDictionary<NSAttributedStringKey, id> *attributes = [NSMutableDictionary dictionary];
        if (font) {
            [attributes setValue:font forKey:NSFontAttributeName];
        }
        if (color) {
            [attributes setValue:color forKey:NSForegroundColorAttributeName];
        }
        NSMutableAttributedString *titleAttributedStr = [[NSMutableAttributedString alloc]initWithString:title attributes:attributes];
        [self.button setAttributedTitle:titleAttributedStr forState:state];
        
        return self;
    };
}

- (LGHButtonMaker *(^)(BOOL))adjustsImageWhenHighlighted {
    return ^LGHButtonMaker* (BOOL flag) {
        self.button.adjustsImageWhenHighlighted = flag;
        
        return self;
    };
}

#pragma mark - 按钮点击事件

- (LGHButtonMaker* (^)(LGHButtonMakerActionBlock))action {
    return ^LGHButtonMaker* (LGHButtonMakerActionBlock action) {
        [self createrActionBlock:^(UIButton *button) {
            if (action) {
                action(self.button);
            }
        } controlEvent:UIControlEventTouchUpInside];
        
        return self;
    };
}

- (LGHButtonMaker* (^)(LGHButtonMakerActionBlock, UIControlEvents))actionWithEvents {
    return ^LGHButtonMaker* (LGHButtonMakerActionBlock action, UIControlEvents events) {
        [self createrActionBlock:^(UIButton *button) {
            if (action) {
                action(self.button);
            }
        } controlEvent:events];
        
        return self;
    };
}

- (void)createrActionBlock:(LGHButtonMakerActionBlock)actionBlock controlEvent:(UIControlEvents)event {
    if(actionBlock) {
        objc_setAssociatedObject(self, @selector(buttonClickAction:), actionBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
    
    [self.button addTarget:self action:@selector(buttonClickAction:) forControlEvents:event];
}

- (void)buttonClickAction:(UIButton *)button {
    LGHButtonMakerActionBlock block = objc_getAssociatedObject(self, _cmd);
    if(block){
        block(button);
    }
}

#pragma mark - UIView公共属性

- (LGHButtonMaker *(^)(BOOL))clipsToBounds {
    return ^LGHButtonMaker* (BOOL flag) {
        self.button.clipsToBounds = flag;
        return self;
    };
}

- (LGHButtonMaker* _Nonnull (^)(UIView * _Nonnull))addTo {
    return ^LGHButtonMaker* (UIView* superview) {
        if (superview) {
            [superview addSubview:self.button];
        }
        return self;
    };
}

- (LGHButtonMaker* _Nonnull (^)(CGRect))frame {
    return ^LGHButtonMaker* (CGRect frame) {
        self.button.frame = frame;
        return self;
    };
}

- (LGHButtonMaker* _Nonnull (^)(CGRect))bounds {
    return ^LGHButtonMaker* (CGRect bounds) {
        self.button.bounds = bounds;
        return self;
    };
}

- (LGHButtonMaker* _Nonnull (^)(CGPoint))center {
    return ^LGHButtonMaker* (CGPoint center) {
        self.button.center = center;
        return self;
    };
}

- (LGHButtonMaker* _Nonnull (^)(UIColor * _Nonnull))backgroundColor {
    return ^LGHButtonMaker* (UIColor* color) {
        self.button.backgroundColor = color;
        return self;
    };
}

- (LGHButtonMaker* _Nonnull (^)(BOOL))hidden {
    return ^LGHButtonMaker* (BOOL flag) {
        self.button.hidden = flag;
        return self;
    };
}

- (LGHButtonMaker* _Nonnull (^)(NSInteger))tag {
    return ^LGHButtonMaker* (NSInteger tag) {
        self.button.tag = tag;
        return self;
    };
}

- (LGHButtonMaker* _Nonnull (^)(BOOL))userInteractionEnabled {
    return ^LGHButtonMaker* (BOOL flag) {
        self.button.userInteractionEnabled = flag;
        return self;
    };
}

- (LGHButtonMaker* _Nonnull (^)(CGFloat))layerCornerRadius {
    return ^LGHButtonMaker* (CGFloat radius) {
        self.button.layer.cornerRadius = radius;
        return self;
    };
}

- (LGHButtonMaker* _Nonnull (^)(BOOL))layerMaskToBounds {
    return ^LGHButtonMaker* (BOOL flag) {
        self.button.layer.masksToBounds = flag;
        return self;
    };
}

- (LGHButtonMaker* _Nonnull (^)(CGFloat))layerBorderWidth {
    return ^LGHButtonMaker* (CGFloat width) {
        self.button.layer.borderWidth = width;
        return self;
    };
}

- (LGHButtonMaker* _Nonnull (^)(UIColor* _Nonnull))layerBorderColor {
    return ^LGHButtonMaker* (UIColor* color) {
        self.button.layer.borderColor = color.CGColor;
        return self;
    };
}

- (LGHButtonMaker* _Nonnull (^)(UIColor* _Nonnull))tintColor {
    return ^LGHButtonMaker* (UIColor* color) {
        self.button.tintColor = color;
        return self;
    };
}

- (LGHButtonMaker *(^)(CGFloat))alpha {
    return ^LGHButtonMaker* (CGFloat alpha) {
        self.button.alpha = alpha;
        return self;
    };
}

- (LGHButtonMaker *(^)(UIViewContentMode))contentMode {
    return ^LGHButtonMaker* (UIViewContentMode mode) {
        self.button.contentMode = mode;
        return self;
    };
}

@end


/// UIButton分类的实现
@implementation UIButton (LGHMaker)

+ (instancetype)LGH_make:(void (^)(LGHButtonMaker* ))make {
    
    LGHButtonMaker* maker = [[LGHButtonMaker alloc] initView];
    if (make) {
        make(maker);
    }
    
    return maker.button;
}

- (instancetype)LGH_make:(void (^)(LGHButtonMaker *))make {
    LGHButtonMaker* maker = [[LGHButtonMaker alloc] initView];
    if (make) {
        make(maker);
    }
    
    return maker.button;
}

@end
