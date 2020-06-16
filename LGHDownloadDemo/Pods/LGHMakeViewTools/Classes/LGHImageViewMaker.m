//
//  LGHImageViewMaker.m
//  Test
//
//  Created by gamesirDev on 9/7/2019.
//  Copyright © 2019 gamesirDev. All rights reserved.
//

#import "LGHImageViewMaker.h"

@interface LGHImageViewMaker ()
@property (nonatomic, retain, readwrite) UIImageView*           imageView;
@end

@implementation LGHImageViewMaker

- (instancetype)initView {
    self.imageView = [UIImageView new];
    
    return self;
}

- (LGHImageViewMaker* (^)(UIImage *))image {
    return ^LGHImageViewMaker* (UIImage* image){
        self.imageView.image = image;
        return self;
    };
}

- (LGHImageViewMaker* (^)(NSString *))imageName {
    return ^LGHImageViewMaker* (NSString* imageName){
        if (imageName && imageName.length > 0) {
            self.imageView.image = [UIImage imageNamed:imageName];
        }
        return self;
    };
}

#pragma mark - UIView公共属性

- (LGHImageViewMaker *(^)(BOOL))clipsToBounds {
    return ^LGHImageViewMaker* (BOOL flag) {
        self.imageView.clipsToBounds = flag;
        return self;
    };
}

- (LGHImageViewMaker* _Nonnull (^)(UIView * _Nonnull))addTo {
    return ^LGHImageViewMaker* (UIView* superview) {
        if (superview) {
            [superview addSubview:self.imageView];
        }
        return self;
    };
}

- (LGHImageViewMaker* _Nonnull (^)(CGRect))frame {
    return ^LGHImageViewMaker* (CGRect frame) {
        self.imageView.frame = frame;
        return self;
    };
}

- (LGHImageViewMaker* _Nonnull (^)(CGRect))bounds {
    return ^LGHImageViewMaker* (CGRect bounds) {
        self.imageView.bounds = bounds;
        return self;
    };
}

- (LGHImageViewMaker* _Nonnull (^)(CGPoint))center {
    return ^LGHImageViewMaker* (CGPoint center) {
        self.imageView.center = center;
        return self;
    };
}

- (LGHImageViewMaker* _Nonnull (^)(UIColor * _Nonnull))backgroundColor {
    return ^LGHImageViewMaker* (UIColor* color) {
        self.imageView.backgroundColor = color;
        return self;
    };
}

- (LGHImageViewMaker* _Nonnull (^)(BOOL))hidden {
    return ^LGHImageViewMaker* (BOOL flag) {
        self.imageView.hidden = flag;
        return self;
    };
}

- (LGHImageViewMaker* _Nonnull (^)(NSInteger))tag {
    return ^LGHImageViewMaker* (NSInteger tag) {
        self.imageView.tag = tag;
        return self;
    };
}

- (LGHImageViewMaker* _Nonnull (^)(BOOL))userInteractionEnabled {
    return ^LGHImageViewMaker* (BOOL flag) {
        self.imageView.userInteractionEnabled = flag;
        return self;
    };
}

- (LGHImageViewMaker* _Nonnull (^)(CGFloat))layerCornerRadius {
    return ^LGHImageViewMaker* (CGFloat radius) {
        self.imageView.layer.cornerRadius = radius;
        return self;
    };
}

- (LGHImageViewMaker* _Nonnull (^)(BOOL))layerMaskToBounds {
    return ^LGHImageViewMaker* (BOOL flag) {
        self.imageView.layer.masksToBounds = flag;
        return self;
    };
}

- (LGHImageViewMaker* _Nonnull (^)(CGFloat))layerBorderWidth {
    return ^LGHImageViewMaker* (CGFloat width) {
        self.imageView.layer.borderWidth = width;
        return self;
    };
}

- (LGHImageViewMaker* _Nonnull (^)(UIColor* _Nonnull))layerBorderColor {
    return ^LGHImageViewMaker* (UIColor* color) {
        self.imageView.layer.borderColor = color.CGColor;
        return self;
    };
}

- (LGHImageViewMaker* _Nonnull (^)(UIColor* _Nonnull))tintColor {
    return ^LGHImageViewMaker* (UIColor* color) {
        self.imageView.tintColor = color;
        return self;
    };
}

- (LGHImageViewMaker *(^)(CGFloat))alpha {
    return ^LGHImageViewMaker* (CGFloat alpha) {
        self.imageView.alpha = alpha;
        return self;
    };
}

- (LGHImageViewMaker *(^)(UIViewContentMode))contentMode {
    return ^LGHImageViewMaker* (UIViewContentMode mode) {
        self.imageView.contentMode = mode;
        return self;
    };
}

@end


/// UIImageView分类的实现
@implementation UIImageView (LGHMaker)

+ (instancetype)LGH_make:(void (^)(LGHImageViewMaker* ))make {
    
    LGHImageViewMaker* maker = [[LGHImageViewMaker alloc] initView];
    if (make) {
        make(maker);
    }
    
    return maker.imageView;
}

@end
