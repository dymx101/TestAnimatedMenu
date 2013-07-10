//
//  GGAnimatedMenu.m
//  TestAnimatedMenu
//
//  Created by Dong Yiming on 7/9/13.
//  Copyright (c) 2013 Dong Yiming. All rights reserved.
//

#import "GGAnimatedMenu.h"
#import <QuartzCore/QuartzCore.h>


@implementation GGAnimatedMenu
{
    NSMutableArray      *_menuItems;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self _doInit];
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self _doInit];
    }
    return self;
}

-(void)_doInit
{
    _menuItems = [NSMutableArray array];
}

-(void)showInView:(UIView *)aView
{
    
}

-(void)addItemWithImage:(UIImage *)aImage selectedImage:(UIImage *)aSelectedImage target:(id)aTarget action:(SEL)anAction
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor blackColor];
    btn.layer.opacity = .9f;
    [btn setImage:aImage forState:UIControlStateNormal];
    [btn setImage:aSelectedImage forState:UIControlStateSelected | UIControlStateHighlighted];
}

@end
