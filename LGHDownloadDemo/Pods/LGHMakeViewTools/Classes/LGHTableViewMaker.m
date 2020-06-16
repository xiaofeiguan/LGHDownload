//
//  LGHTableViewMaker.m
//  Test
//
//  Created by gamesirDev on 9/7/2019.
//  Copyright © 2019 gamesirDev. All rights reserved.
//

#import "LGHTableViewMaker.h"

@interface LGHTableViewMaker ()
@property (nonatomic, retain, readwrite) UITableView*           tableView;
@end

@implementation LGHTableViewMaker

- (instancetype)initWithStyle:(UITableViewStyle)style {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:style];
    if (@available(iOS 13.0,*)) {
        self.tableView.backgroundColor = [UIColor colorWithWhite:0.95 alpha:0];
    }
    return self;
}

- (LGHTableViewMaker* (^)(id))delegate {
    return ^LGHTableViewMaker* (id object) {
        self.tableView.delegate = object;
        return self;
    };
}

- (LGHTableViewMaker* (^)(id))dataSource {
    return ^LGHTableViewMaker* (id object) {
        self.tableView.dataSource = object;
        return self;
    };
}

- (LGHTableViewMaker* (^)(__unsafe_unretained Class))registerClass {
    return ^LGHTableViewMaker* (Class aClass) {
        [self.tableView registerClass:[aClass class] forCellReuseIdentifier:NSStringFromClass(aClass)];
        return self;
    };
}

-(LGHTableViewMaker*(^)(__unsafe_unretained UINib* ,NSString *))registerNib{
    return ^LGHTableViewMaker*(UINib *aNib ,NSString*identify){
        [self.tableView registerNib:aNib forCellReuseIdentifier:identify];
        return self;
    };
}

- (LGHTableViewMaker *(^)(UITableViewCellSeparatorStyle))separatorStyle {
    return ^LGHTableViewMaker* (UITableViewCellSeparatorStyle style) {
        self.tableView.separatorStyle = style;
        return self;
    };
}

- (LGHTableViewMaker *(^)(UIColor *))separatorColor {
    return ^LGHTableViewMaker* (UIColor* color) {
        self.tableView.separatorColor = color;
        return self;
    };
}

- (LGHTableViewMaker *(^)(UIEdgeInsets))separatorInset {
    return ^LGHTableViewMaker* (UIEdgeInsets insets) {
        self.tableView.separatorInset = insets;
        return self;
    };
}

- (LGHTableViewMaker *(^)(UIView *))tableFooterView {
    return ^LGHTableViewMaker* (UIView* view) {
        self.tableView.tableFooterView = view;
        return self;
    };
}

- (LGHTableViewMaker *(^)(CGFloat))estimatedRowHeight {
    return ^LGHTableViewMaker* (CGFloat height) {
        self.tableView.estimatedRowHeight = height;
        return self;
    };
}

#pragma mark - UIView公共属性

- (LGHTableViewMaker *(^)(BOOL))clipsToBounds {
    return ^LGHTableViewMaker* (BOOL flag) {
        self.tableView.clipsToBounds = flag;
        return self;
    };
}

- (LGHTableViewMaker* _Nonnull (^)(UIView * _Nonnull))addTo {
    return ^LGHTableViewMaker* (UIView* superview) {
        if (superview) {
            [superview addSubview:self.tableView];
        }
        return self;
    };
}

- (LGHTableViewMaker* _Nonnull (^)(CGRect))frame {
    return ^LGHTableViewMaker* (CGRect frame) {
        self.tableView.frame = frame;
        return self;
    };
}

- (LGHTableViewMaker* _Nonnull (^)(CGRect))bounds {
    return ^LGHTableViewMaker* (CGRect bounds) {
        self.tableView.bounds = bounds;
        return self;
    };
}

- (LGHTableViewMaker* _Nonnull (^)(CGPoint))center {
    return ^LGHTableViewMaker* (CGPoint center) {
        self.tableView.center = center;
        return self;
    };
}

- (LGHTableViewMaker* _Nonnull (^)(UIColor * _Nonnull))backgroundColor {
    return ^LGHTableViewMaker* (UIColor* color) {
        self.tableView.backgroundColor = color;
        return self;
    };
}

- (LGHTableViewMaker* _Nonnull (^)(BOOL))hidden {
    return ^LGHTableViewMaker* (BOOL flag) {
        self.tableView.hidden = flag;
        return self;
    };
}

- (LGHTableViewMaker* _Nonnull (^)(NSInteger))tag {
    return ^LGHTableViewMaker* (NSInteger tag) {
        self.tableView.tag = tag;
        return self;
    };
}

- (LGHTableViewMaker* _Nonnull (^)(BOOL))userInteractionEnabled {
    return ^LGHTableViewMaker* (BOOL flag) {
        self.tableView.userInteractionEnabled = flag;
        return self;
    };
}

- (LGHTableViewMaker* _Nonnull (^)(CGFloat))layerCornerRadius {
    return ^LGHTableViewMaker* (CGFloat radius) {
        self.tableView.layer.cornerRadius = radius;
        return self;
    };
}

- (LGHTableViewMaker* _Nonnull (^)(BOOL))layerMaskToBounds {
    return ^LGHTableViewMaker* (BOOL flag) {
        self.tableView.layer.masksToBounds = flag;
        return self;
    };
}

- (LGHTableViewMaker* _Nonnull (^)(CGFloat))layerBorderWidth {
    return ^LGHTableViewMaker* (CGFloat width) {
        self.tableView.layer.borderWidth = width;
        return self;
    };
}

- (LGHTableViewMaker* _Nonnull (^)(UIColor* _Nonnull))layerBorderColor {
    return ^LGHTableViewMaker* (UIColor* color) {
        self.tableView.layer.borderColor = color.CGColor;
        return self;
    };
}

- (LGHTableViewMaker* _Nonnull (^)(UIColor* _Nonnull))tintColor {
    return ^LGHTableViewMaker* (UIColor* color) {
        self.tableView.tintColor = color;
        return self;
    };
}

- (LGHTableViewMaker *(^)(CGFloat))alpha {
    return ^LGHTableViewMaker* (CGFloat alpha) {
        self.tableView.alpha = alpha;
        return self;
    };
}

- (LGHTableViewMaker *(^)(UIViewContentMode))contentMode {
    return ^LGHTableViewMaker* (UIViewContentMode mode) {
        self.tableView.contentMode = mode;
        return self;
    };
}

@end


/// UITableView分类的实现
@implementation UITableView (LGHMaker)

+ (instancetype)LGH_make:(void (^)(LGHTableViewMaker* ))make style:(UITableViewStyle)style {
    
    LGHTableViewMaker* maker = [[LGHTableViewMaker alloc] initWithStyle:style];
    if (make) {
        make(maker);
    }
    
    return maker.tableView;
}
@end
