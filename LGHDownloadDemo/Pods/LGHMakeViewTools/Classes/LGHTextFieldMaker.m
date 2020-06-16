//
//  LGHTextFieldMaker.m
//  Test
//
//  Created by gamesirDev on 12/7/2019.
//  Copyright © 2019 gamesirDev. All rights reserved.
//

#import "LGHTextFieldMaker.h"

@interface LGHTextFieldMaker ()
@property (nonatomic, retain) UITextField*              textField;
@end

@implementation LGHTextFieldMaker

- (instancetype)initView {
    self.textField = [UITextField new];
    
    return self;
}

- (LGHTextFieldMaker *(^)(NSString *))text {
    return ^LGHTextFieldMaker *(NSString *text) {
        self.textField.text = text;
        return self;
    };
}

- (LGHTextFieldMaker *(^)(UIColor *))textColor {
    return ^LGHTextFieldMaker *(UIColor *color) {
        self.textField.textColor = color;
        return self;
    };
}

- (LGHTextFieldMaker *(^)(NSAttributedString *))attributedText {
    return ^LGHTextFieldMaker *(NSAttributedString *atbString) {
        self.textField.attributedText = atbString;
        return self;
    };
}

- (LGHTextFieldMaker *(^)(UIFont *))font {
    return ^LGHTextFieldMaker *(UIFont *font) {
        self.textField.font = font;
        return self;
    };
}

- (LGHTextFieldMaker *(^)(NSTextAlignment))textAlignment {
    return ^LGHTextFieldMaker *(NSTextAlignment alignment) {
        self.textField.textAlignment = alignment;
        return self;
    };
}

- (LGHTextFieldMaker* (^)(id))delegate {
    return ^LGHTextFieldMaker* (id object) {
        self.textField.delegate = object;
        return self;
    };
}

- (LGHTextFieldMaker * _Nonnull (^)(NSString * _Nonnull))placeholder {
    return ^LGHTextFieldMaker* (NSString* string) {
        
        if (@available(iOS 13.0,*)) {
            self.textField.attributedPlaceholder = [[NSAttributedString alloc]initWithString:string attributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor]}];
        }else{
           
            self.textField.placeholder = string;
        }
        return self;
    };
}

- (LGHTextFieldMaker * _Nonnull (^)(UIColor * _Nonnull))placeholderColor {
    return ^LGHTextFieldMaker* (UIColor* color) {
        if (@available(iOS 13.0,*)) {
//            NSLog(@"%@ - %@",self.textField.placeholder,self.textField.attributedPlaceholder.string);
            if ((self.textField.placeholder)&&self.textField.placeholder.length>0) {
                self.textField.attributedPlaceholder = [[NSAttributedString alloc]initWithString:self.textField.attributedPlaceholder.string attributes:@{NSForegroundColorAttributeName:color}];
            }
        }else{
            [self.textField setValue:color
                          forKeyPath:@"_placeholderLabel.textColor"];
        }
        return self;
    };
}

- (LGHTextFieldMaker * _Nonnull (^)(BOOL))clearsOnBeginEditing {
    return ^LGHTextFieldMaker* (BOOL flag) {
        self.textField.clearsOnBeginEditing = flag;
        return self;
    };
}

- (LGHTextFieldMaker * _Nonnull (^)(UIView * _Nonnull))leftView {
    return ^LGHTextFieldMaker* (UIView* view) {
        self.textField.leftView = view;
        return self;
    };
}

- (LGHTextFieldMaker * _Nonnull (^)(UITextFieldViewMode))leftViewMode {
    return ^LGHTextFieldMaker* (UITextFieldViewMode mode) {
        self.textField.leftViewMode = mode;
        return self;
    };
}

- (LGHTextFieldMaker * _Nonnull (^)(UITextFieldViewMode))clearButtonMode {
    return ^LGHTextFieldMaker* (UITextFieldViewMode mode) {
        self.textField.clearButtonMode = mode;
        return self;
    };
}

- (LGHTextFieldMaker * _Nonnull (^)(UITextBorderStyle))borderStyle {
    return ^LGHTextFieldMaker* (UITextBorderStyle style) {
        self.textField.borderStyle = style;
        return self;
    };
}

- (LGHTextFieldMaker * _Nonnull (^)(BOOL))secureTextEntry {
    return ^LGHTextFieldMaker* (BOOL flag) {
        self.textField.secureTextEntry = flag;
        return self;
    };
}

#pragma mark - UIView公共属性

- (LGHTextFieldMaker *(^)(BOOL))clipsToBounds {
    return ^LGHTextFieldMaker* (BOOL flag) {
        self.textField.clipsToBounds = flag;
        return self;
    };
}

- (LGHTextFieldMaker* _Nonnull (^)(UIView * _Nonnull))addTo {
    return ^LGHTextFieldMaker* (UIView* superview) {
        if (superview) {
            [superview addSubview:self.textField];
        }
        return self;
    };
}

- (LGHTextFieldMaker* _Nonnull (^)(CGRect))frame {
    return ^LGHTextFieldMaker* (CGRect frame) {
        self.textField.frame = frame;
        return self;
    };
}

- (LGHTextFieldMaker* _Nonnull (^)(CGRect))bounds {
    return ^LGHTextFieldMaker* (CGRect bounds) {
        self.textField.bounds = bounds;
        return self;
    };
}

- (LGHTextFieldMaker* _Nonnull (^)(CGPoint))center {
    return ^LGHTextFieldMaker* (CGPoint center) {
        self.textField.center = center;
        return self;
    };
}

- (LGHTextFieldMaker* _Nonnull (^)(UIColor * _Nonnull))backgroundColor {
    return ^LGHTextFieldMaker* (UIColor* color) {
        self.textField.backgroundColor = color;
        return self;
    };
}

- (LGHTextFieldMaker* _Nonnull (^)(BOOL))hidden {
    return ^LGHTextFieldMaker* (BOOL flag) {
        self.textField.hidden = flag;
        return self;
    };
}

- (LGHTextFieldMaker* _Nonnull (^)(NSInteger))tag {
    return ^LGHTextFieldMaker* (NSInteger tag) {
        self.textField.tag = tag;
        return self;
    };
}

- (LGHTextFieldMaker* _Nonnull (^)(BOOL))userInteractionEnabled {
    return ^LGHTextFieldMaker* (BOOL flag) {
        self.textField.userInteractionEnabled = flag;
        return self;
    };
}

- (LGHTextFieldMaker* _Nonnull (^)(CGFloat))layerCornerRadius {
    return ^LGHTextFieldMaker* (CGFloat radius) {
        self.textField.layer.cornerRadius = radius;
        return self;
    };
}

- (LGHTextFieldMaker* _Nonnull (^)(BOOL))layerMaskToBounds {
    return ^LGHTextFieldMaker* (BOOL flag) {
        self.textField.layer.masksToBounds = flag;
        return self;
    };
}

- (LGHTextFieldMaker* _Nonnull (^)(CGFloat))layerBorderWidth {
    return ^LGHTextFieldMaker* (CGFloat width) {
        self.textField.layer.borderWidth = width;
        return self;
    };
}

- (LGHTextFieldMaker* _Nonnull (^)(UIColor* _Nonnull))layerBorderColor {
    return ^LGHTextFieldMaker* (UIColor* color) {
        self.textField.layer.borderColor = color.CGColor;
        return self;
    };
}

- (LGHTextFieldMaker* _Nonnull (^)(UIColor* _Nonnull))tintColor {
    return ^LGHTextFieldMaker* (UIColor* color) {
        self.textField.tintColor = color;
        return self;
    };
}

- (LGHTextFieldMaker *(^)(CGFloat))alpha {
    return ^LGHTextFieldMaker* (CGFloat alpha) {
        self.textField.alpha = alpha;
        return self;
    };
}

- (LGHTextFieldMaker *(^)(UIViewContentMode))contentMode {
    return ^LGHTextFieldMaker* (UIViewContentMode mode) {
        self.textField.contentMode = mode;
        return self;
    };
}

@end


/// UITextField分类的实现
@implementation UITextField (LGHMaker)

+ (instancetype)LGH_make:(void (^)(LGHTextFieldMaker *))make {
    
    LGHTextFieldMaker *maker = [[LGHTextFieldMaker alloc] initView];
    if (make) {
        make(maker);
    }
    
    return maker.textField;
}

@end
