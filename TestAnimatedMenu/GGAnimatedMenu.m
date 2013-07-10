//
//  GGAnimatedMenu.m
//  TestAnimatedMenu
//
//  Created by Dong Yiming on 7/9/13.
//  Copyright (c) 2013 Dong Yiming. All rights reserved.
//

#import "GGAnimatedMenu.h"
#import <QuartzCore/QuartzCore.h>

#define DEFAULT_BUTTON_SIZE         40
#define DEFAULT_CIRCLE_RADIOUS      100

@implementation GGAnimatedMenu
{
    NSMutableArray      *_menuItems;
    UIView              *_dimedView;
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
    
    _dimedView = [[UIView alloc] initWithFrame:self.bounds];
    _dimedView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _dimedView.backgroundColor = [UIColor orangeColor];
    _dimedView.layer.opacity = .5f;
    [self addSubview:_dimedView];
}

-(void)showInView:(UIView *)aView
{
    self.frame = aView.bounds;
    int itemCount = _menuItems.count;
    
    if (itemCount)
    {
        float startAngel = M_PI_2;
        float angelStep = 2 * M_PI / itemCount;
        CGPoint centerPt = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, centerPt.y, self.bounds.size.width, 1)];
        line.backgroundColor = [UIColor blueColor];
        line.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin   |
                                 UIViewAutoresizingFlexibleRightMargin  |
                                 UIViewAutoresizingFlexibleTopMargin    |
                                 UIViewAutoresizingFlexibleBottomMargin);
        [self addSubview:line];
        
        UIView *centerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        centerView.backgroundColor = [UIColor redColor];
        centerView.layer.cornerRadius = 50.f;
        centerView.center = centerPt;
        [self addSubview:centerView];
        
        
        for (int i = 0; i < itemCount; i++)
        {
            float offsetX = DEFAULT_CIRCLE_RADIOUS * cos(startAngel) - DEFAULT_BUTTON_SIZE / 2;
            float offsetY = DEFAULT_CIRCLE_RADIOUS * sin(startAngel) - DEFAULT_BUTTON_SIZE / 2;
            UIButton *theBtn = _menuItems[i];
            theBtn.center = CGPointMake(centerPt.x + offsetX, centerPt.y + offsetY);
            
            startAngel += angelStep;
        }
    }
    
    [aView addSubview:self];
}

-(void)addItemWithImage:(UIImage *)aImage selectedImage:(UIImage *)aSelectedImage target:(id)aTarget action:(SEL)anAction
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, DEFAULT_BUTTON_SIZE, DEFAULT_BUTTON_SIZE);
    btn.layer.cornerRadius = DEFAULT_BUTTON_SIZE / 2;
    btn.backgroundColor = [UIColor blackColor];
    btn.layer.opacity = .5f;
    [btn setImage:aImage forState:UIControlStateNormal];
    [btn setImage:aSelectedImage forState:UIControlStateSelected | UIControlStateHighlighted];
    
    if (aTarget && anAction)
    {
        [btn addTarget:aTarget action:anAction forControlEvents:UIControlEventTouchUpInside];
    }
    
    [self addSubview:btn];
    [_menuItems addObject:btn];
}

@end
