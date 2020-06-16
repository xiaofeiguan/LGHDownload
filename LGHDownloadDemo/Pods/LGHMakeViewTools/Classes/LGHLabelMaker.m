//
//  LGHLabelMaker.m
//  Test
//
//  Created by gamesirDev on 9/7/2019.
//  Copyright © 2019 gamesirDev. All rights reserved.
//

#import "LGHLabelMaker.h"

@interface LGHLabelMaker ()
@property (nonatomic, retain, readwrite) UILabel*           label;
@end

@implementation LGHLabelMaker

- (instancetype)initView {
    self.label = [UILabel new];
    
    return self;
}


- (LGHLabelMaker *(^)(NSString *))text {
    return ^LGHLabelMaker *(NSString *text) {
        self.label.text = text;
        return self;
    };
}

- (LGHLabelMaker *(^)(UIColor *))textColor {
    return ^LGHLabelMaker *(UIColor *color) {
        self.label.textColor = color;
        return self;
    };
}

- (LGHLabelMaker *(^)(NSAttributedString *))attributedText {
    return ^LGHLabelMaker *(NSAttributedString *atbString) {
        self.label.attributedText = atbString;
        return self;
    };
}

- (LGHLabelMaker *(^)(UIFont *))font {
    return ^LGHLabelMaker *(UIFont *font) {
        self.label.font = font;
        return self;
    };
}

- (LGHLabelMaker *(^)(NSTextAlignment))textAlignment {
    return ^LGHLabelMaker *(NSTextAlignment alignment) {
        self.label.textAlignment = alignment;
        return self;
    };
}

- (LGHLabelMaker *(^)(NSInteger))numberOfLines {
    return ^LGHLabelMaker *(NSInteger lines) {
        self.label.numberOfLines = lines;
        return self;
    };
}

- (LGHLabelMaker *(^)(NSLineBreakMode))lineBreakMode {
    return ^LGHLabelMaker *(NSLineBreakMode mode) {
        self.label.lineBreakMode = mode;
        return self;
    };
}


#pragma mark - UIView公共属性

- (LGHLabelMaker *(^)(BOOL))clipsToBounds {
    return ^LGHLabelMaker* (BOOL flag) {
        self.label.clipsToBounds = flag;
        return self;
    };
}

- (LGHLabelMaker* _Nonnull (^)(UIView * _Nonnull))addTo {
    return ^LGHLabelMaker* (UIView* superview) {
        if (superview) {
            [superview addSubview:self.label];
        }
        return self;
    };
}

- (LGHLabelMaker* _Nonnull (^)(CGRect))frame {
    return ^LGHLabelMaker* (CGRect frame) {
        self.label.frame = frame;
        return self;
    };
}

- (LGHLabelMaker* _Nonnull (^)(CGRect))bounds {
    return ^LGHLabelMaker* (CGRect bounds) {
        self.label.bounds = bounds;
        return self;
    };
}

- (LGHLabelMaker* _Nonnull (^)(CGPoint))center {
    return ^LGHLabelMaker* (CGPoint center) {
        self.label.center = center;
        return self;
    };
}

- (LGHLabelMaker* _Nonnull (^)(UIColor * _Nonnull))backgroundColor {
    return ^LGHLabelMaker* (UIColor* color) {
        self.label.backgroundColor = color;
        return self;
    };
}

- (LGHLabelMaker* _Nonnull (^)(BOOL))hidden {
    return ^LGHLabelMaker* (BOOL flag) {
        self.label.hidden = flag;
        return self;
    };
}

- (LGHLabelMaker* _Nonnull (^)(NSInteger))tag {
    return ^LGHLabelMaker* (NSInteger tag) {
        self.label.tag = tag;
        return self;
    };
}

- (LGHLabelMaker* _Nonnull (^)(BOOL))userInteractionEnabled {
    return ^LGHLabelMaker* (BOOL flag) {
        self.label.userInteractionEnabled = flag;
        return self;
    };
}

- (LGHLabelMaker* _Nonnull (^)(CGFloat))layerCornerRadius {
    return ^LGHLabelMaker* (CGFloat radius) {
        self.label.layer.cornerRadius = radius;
        return self;
    };
}

- (LGHLabelMaker* _Nonnull (^)(BOOL))layerMaskToBounds {
    return ^LGHLabelMaker* (BOOL flag) {
        self.label.layer.masksToBounds = flag;
        return self;
    };
}

- (LGHLabelMaker* _Nonnull (^)(CGFloat))layerBorderWidth {
    return ^LGHLabelMaker* (CGFloat width) {
        self.label.layer.borderWidth = width;
        return self;
    };
}

- (LGHLabelMaker* _Nonnull (^)(UIColor* _Nonnull))layerBorderColor {
    return ^LGHLabelMaker* (UIColor* color) {
        self.label.layer.borderColor = color.CGColor;
        return self;
    };
}

- (LGHLabelMaker* _Nonnull (^)(UIColor* _Nonnull))tintColor {
    return ^LGHLabelMaker* (UIColor* color) {
        self.label.tintColor = color;
        return self;
    };
}

- (LGHLabelMaker *(^)(CGFloat))alpha {
    return ^LGHLabelMaker* (CGFloat alpha) {
        self.label.alpha = alpha;
        return self;
    };
}

- (LGHLabelMaker *(^)(UIViewContentMode))contentMode {
    return ^LGHLabelMaker* (UIViewContentMode mode) {
        self.label.contentMode = mode;
        return self;
    };
}

@end


/// UILabel分类的实现
@implementation UILabel (LGHMaker)

+ (instancetype)LGH_make:(void (^)(LGHLabelMaker *))make {
    
    LGHLabelMaker *maker = [[LGHLabelMaker alloc] initView];
    if (make) {
        make(maker);
    }
    
    return maker.label;
}

@end
