//
//  LGHViewMaker.m
//  Test
//
//  Created by gamesirDev on 8/7/2019.
//  Copyright © 2019 gamesirDev. All rights reserved.
//

#import "LGHViewMaker.h"

@interface LGHViewMaker ()
@property (nonatomic, retain, readwrite) UIView*           view;
@end

@implementation LGHViewMaker

- (instancetype)initView {
    self.view = [UIView new];
    
    return self;
}

- (LGHViewMaker *(^)(BOOL))clipsToBounds {
    return ^LGHViewMaker* (BOOL flag) {
        self.view.clipsToBounds = flag;
        return self;
    };
}

- (LGHViewMaker* _Nonnull (^)(UIView * _Nonnull))addTo {
    return ^LGHViewMaker* (UIView* superview) {
        if (superview) {
            [superview addSubview:self.view];
        }
        return self;
    };
}

- (LGHViewMaker* _Nonnull (^)(CGRect))frame {
    return ^LGHViewMaker* (CGRect frame) {
        self.view.frame = frame;
        return self;
    };
}

- (LGHViewMaker* _Nonnull (^)(CGRect))bounds {
    return ^LGHViewMaker* (CGRect bounds) {
        self.view.bounds = bounds;
        return self;
    };
}

- (LGHViewMaker* _Nonnull (^)(CGPoint))center {
    return ^LGHViewMaker* (CGPoint center) {
        self.view.center = center;
        return self;
    };
}

- (LGHViewMaker* _Nonnull (^)(UIColor * _Nonnull))backgroundColor {
    return ^LGHViewMaker* (UIColor* color) {
        self.view.backgroundColor = color;
        return self;
    };
}

- (LGHViewMaker* _Nonnull (^)(BOOL))hidden {
    return ^LGHViewMaker* (BOOL flag) {
        self.view.hidden = flag;
        return self;
    };
}

- (LGHViewMaker* _Nonnull (^)(NSInteger))tag {
    return ^LGHViewMaker* (NSInteger tag) {
        self.view.tag = tag;
        return self;
    };
}

- (LGHViewMaker* _Nonnull (^)(BOOL))userInteractionEnabled {
    return ^LGHViewMaker* (BOOL flag) {
        self.view.userInteractionEnabled = flag;
        return self;
    };
}

- (LGHViewMaker* _Nonnull (^)(CGFloat))layerCornerRadius {
    return ^LGHViewMaker* (CGFloat radius) {
        self.view.layer.cornerRadius = radius;
        return self;
    };
}

- (LGHViewMaker* _Nonnull (^)(BOOL))layerMaskToBounds {
    return ^LGHViewMaker* (BOOL flag) {
        self.view.layer.masksToBounds = flag;
        return self;
    };
}

- (LGHViewMaker* _Nonnull (^)(CGFloat))layerBorderWidth {
    return ^LGHViewMaker* (CGFloat width) {
        self.view.layer.borderWidth = width;
        return self;
    };
}

- (LGHViewMaker* _Nonnull (^)(UIColor* _Nonnull))layerBorderColor {
    return ^LGHViewMaker* (UIColor* color) {
        self.view.layer.borderColor = color.CGColor;
        return self;
    };
}

- (LGHViewMaker* _Nonnull (^)(UIColor* _Nonnull))tintColor {
    return ^LGHViewMaker* (UIColor* color) {
        self.view.tintColor = color;
        return self;
    };
}

- (LGHViewMaker *(^)(CGFloat))alpha {
    return ^LGHViewMaker* (CGFloat alpha) {
        self.view.alpha = alpha;
        return self;
    };
}

- (LGHViewMaker *(^)(UIViewContentMode))contentMode {
    return ^LGHViewMaker* (UIViewContentMode mode) {
        self.view.contentMode = mode;
        return self;
    };
}

@end


/// UIView分类的实现
@implementation UIView (LGHMaker)

+ (instancetype)LGH_make:(void (^)(LGHViewMaker* ))make {
    
    LGHViewMaker* maker = [[LGHViewMaker alloc] initView];
    if (make) {
        make(maker);
    }
    
    return maker.view;
}

@end
