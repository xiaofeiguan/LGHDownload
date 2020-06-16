//
//  LGHTextViewMaker.m
//  Animation
//
//  Created by gamesirDev on 26/12/2019.
//  Copyright © 2019 Lfm. All rights reserved.
//

#import "LGHTextViewMaker.h"

@interface LGHTextViewMaker ()
@property (nonatomic, retain) UITextView*              textView;
@end

@implementation LGHTextViewMaker

- (instancetype)initView {
    self.textView = [UITextView new];
    
    return self;
}

- (LGHTextViewMaker *(^)(NSString *))text {
    return ^LGHTextViewMaker *(NSString *text) {
        self.textView.text = text;
        return self;
    };
}

- (LGHTextViewMaker *(^)(UIColor *))textColor {
    return ^LGHTextViewMaker *(UIColor *color) {
        self.textView.textColor = color;
        return self;
    };
}

- (LGHTextViewMaker *(^)(NSAttributedString *))attributedText {
    return ^LGHTextViewMaker *(NSAttributedString *atbString) {
        self.textView.attributedText = atbString;
        return self;
    };
}

- (LGHTextViewMaker *(^)(UIFont *))font {
    return ^LGHTextViewMaker *(UIFont *font) {
        self.textView.font = font;
        return self;
    };
}

- (LGHTextViewMaker *(^)(NSTextAlignment))textAlignment {
    return ^LGHTextViewMaker *(NSTextAlignment alignment) {
        self.textView.textAlignment = alignment;
        return self;
    };
}

- (LGHTextViewMaker* (^)(id))delegate {
    return ^LGHTextViewMaker* (id object) {
        self.textView.delegate = object;
        return self;
    };
}

- (LGHTextViewMaker * _Nonnull (^)(UILabel * _Nonnull))placeholder {
    return ^LGHTextViewMaker* (UILabel* label) {
        [self.textView setValue:label forKey:@"_placeholderLabel"];
        return self;
    };
}

- (LGHTextViewMaker * _Nonnull (^)(UIColor * _Nonnull))placeholderColor {
    return ^LGHTextViewMaker* (UIColor* color) {
        [self.textView setValue:color
                      forKeyPath:@"_placeholderLabel.textColor"];
        return self;
    };
}

- (LGHTextViewMaker * _Nonnull (^)(BOOL))secureTextEntry {
    return ^LGHTextViewMaker* (BOOL flag) {
        self.textView.secureTextEntry = flag;
        return self;
    };
}

#pragma mark - UIView公共属性

- (LGHTextViewMaker *(^)(BOOL))clipsToBounds {
    return ^LGHTextViewMaker* (BOOL flag) {
        self.textView.clipsToBounds = flag;
        return self;
    };
}

- (LGHTextViewMaker* _Nonnull (^)(UIView * _Nonnull))addTo {
    return ^LGHTextViewMaker* (UIView* superview) {
        if (superview) {
            [superview addSubview:self.textView];
        }
        return self;
    };
}

- (LGHTextViewMaker* _Nonnull (^)(CGRect))frame {
    return ^LGHTextViewMaker* (CGRect frame) {
        self.textView.frame = frame;
        return self;
    };
}

- (LGHTextViewMaker* _Nonnull (^)(CGRect))bounds {
    return ^LGHTextViewMaker* (CGRect bounds) {
        self.textView.bounds = bounds;
        return self;
    };
}

- (LGHTextViewMaker* _Nonnull (^)(CGPoint))center {
    return ^LGHTextViewMaker* (CGPoint center) {
        self.textView.center = center;
        return self;
    };
}

- (LGHTextViewMaker* _Nonnull (^)(UIColor * _Nonnull))backgroundColor {
    return ^LGHTextViewMaker* (UIColor* color) {
        self.textView.backgroundColor = color;
        return self;
    };
}

- (LGHTextViewMaker* _Nonnull (^)(BOOL))hidden {
    return ^LGHTextViewMaker* (BOOL flag) {
        self.textView.hidden = flag;
        return self;
    };
}

- (LGHTextViewMaker* _Nonnull (^)(NSInteger))tag {
    return ^LGHTextViewMaker* (NSInteger tag) {
        self.textView.tag = tag;
        return self;
    };
}

- (LGHTextViewMaker* _Nonnull (^)(BOOL))userInteractionEnabled {
    return ^LGHTextViewMaker* (BOOL flag) {
        self.textView.userInteractionEnabled = flag;
        return self;
    };
}

- (LGHTextViewMaker* _Nonnull (^)(CGFloat))layerCornerRadius {
    return ^LGHTextViewMaker* (CGFloat radius) {
        self.textView.layer.cornerRadius = radius;
        return self;
    };
}

- (LGHTextViewMaker* _Nonnull (^)(BOOL))layerMaskToBounds {
    return ^LGHTextViewMaker* (BOOL flag) {
        self.textView.layer.masksToBounds = flag;
        return self;
    };
}

- (LGHTextViewMaker* _Nonnull (^)(CGFloat))layerBorderWidth {
    return ^LGHTextViewMaker* (CGFloat width) {
        self.textView.layer.borderWidth = width;
        return self;
    };
}

- (LGHTextViewMaker* _Nonnull (^)(UIColor* _Nonnull))layerBorderColor {
    return ^LGHTextViewMaker* (UIColor* color) {
        self.textView.layer.borderColor = color.CGColor;
        return self;
    };
}

- (LGHTextViewMaker* _Nonnull (^)(UIColor* _Nonnull))tintColor {
    return ^LGHTextViewMaker* (UIColor* color) {
        self.textView.tintColor = color;
        return self;
    };
}

- (LGHTextViewMaker *(^)(CGFloat))alpha {
    return ^LGHTextViewMaker* (CGFloat alpha) {
        self.textView.alpha = alpha;
        return self;
    };
}

- (LGHTextViewMaker *(^)(UIViewContentMode))contentMode {
    return ^LGHTextViewMaker* (UIViewContentMode mode) {
        self.textView.contentMode = mode;
        return self;
    };
}

@end


/// UITextView分类的实现
@implementation UITextView (LGHMaker)

+ (instancetype)LGH_make:(void (^)(LGHTextViewMaker *))make {
    
    LGHTextViewMaker *maker = [[LGHTextViewMaker alloc] initView];
    if (make) {
        make(maker);
    }
    
    return maker.textView;
}

@end
