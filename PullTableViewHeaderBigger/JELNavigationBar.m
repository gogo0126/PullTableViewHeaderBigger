//
//  JELNavigationBar.m
//  PullTableViewHeaderBigger
//
//  Created by jerryliao on 2018/4/21.
//  Copyright © 2018年 jerryliao. All rights reserved.
//

#import "JELNavigationBar.h"

@interface JELNavigationBar ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation JELNavigationBar

- (void)setTitleColor:(UIColor *)titleColor {
    [self.titleLabel setTextColor:titleColor];
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self xibSetup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self xibSetup];
    }
    return self;
}

- (void)xibSetup {
    UIView *view = [self loadViewFromNib];
    [self addSubview:view];
    
    view.frame = self.bounds;
    view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
}

- (UIView *)loadViewFromNib {
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    UINib *nib = [UINib nibWithNibName:NSStringFromClass([self class]) bundle:bundle];
    UIView *view = (UIView *)[nib instantiateWithOwner:self options:nil].firstObject;
    return view;
}


@end
