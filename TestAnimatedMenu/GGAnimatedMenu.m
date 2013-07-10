//
//  GGAnimatedMenu.m
//  TestAnimatedMenu
//
//  Created by Dong Yiming on 7/9/13.
//  Copyright (c) 2013 Dong Yiming. All rights reserved.
//

#import "GGAnimatedMenu.h"
#import <QuartzCore/QuartzCore.h>

#define DEFAULT_BUTTON_SIZE         40.f
#define DEFAULT_CIRCLE_RADIOUS          200.f
#define DEFAULT_CIRCLE_RADIOUS_NEAR     80.f

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
    _dimedView.backgroundColor = [UIColor blackColor];
    _dimedView.layer.opacity = .5f;
    [self addSubview:_dimedView];
    
    UITapGestureRecognizer *tapToDissmiss = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
    [_dimedView addGestureRecognizer:tapToDissmiss];
}

-(void)showInView:(UIView *)aView
{
    self.frame = aView.bounds;
    int itemCount = _menuItems.count;
    
    //        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, centerPt.y, self.bounds.size.width, 1)];
    //        line.backgroundColor = [UIColor blueColor];
    //        line.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin   |
    //                                 UIViewAutoresizingFlexibleRightMargin  |
    //                                 UIViewAutoresizingFlexibleTopMargin    |
    //                                 UIViewAutoresizingFlexibleBottomMargin);
    //        [self addSubview:line];
    
    //        UIView *centerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    //        centerView.backgroundColor = [UIColor redColor];
    //        centerView.layer.cornerRadius = 5.f;
    //        centerView.center = centerPt;
    //        [self addSubview:centerView];
    
    if (itemCount)
    {
        self.alpha = .3f;
        [self _arrangeButtonsWithRadious:DEFAULT_CIRCLE_RADIOUS];
        
        //
        [UIView animateWithDuration:.2f animations:^{
            
            [self _arrangeButtonsWithRadious:DEFAULT_CIRCLE_RADIOUS_NEAR];
            self.alpha = 1.f;
            
        } completion:^(BOOL finished) {
            //
        }];
    }
    
    [aView addSubview:self];
}

-(void)dismiss
{
    [UIView animateWithDuration:.2f animations:^{
        
        [self _arrangeButtonsWithRadious:DEFAULT_CIRCLE_RADIOUS];
        self.alpha = .3f;
        
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

-(void)_arrangeButtonsWithRadious:(float)aRadious
{
    int itemCount = _menuItems.count;
    
    if (itemCount)
    {
        float startAngel = M_PI_2;
        float angelStep = 2 * M_PI / itemCount;
        CGPoint centerPt = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
        
        for (int i = 0; i < itemCount; i++)
        {
            float offsetX = aRadious * cos(startAngel);// - DEFAULT_BUTTON_SIZE / 2;
            float offsetY = aRadious * sin(startAngel);// - DEFAULT_BUTTON_SIZE / 2;
            
            //NSLog(@"center:%@, radious:%f, angel:%f, size:%f, offsetX:%f, offsetY:%f", NSStringFromCGPoint(centerPt), DEFAULT_CIRCLE_RADIOUS, (startAngel * 180 / M_PI), DEFAULT_BUTTON_SIZE, offsetX, offsetY);
            
            UIButton *theBtn = _menuItems[i];
            theBtn.center = CGPointMake(centerPt.x - offsetX, centerPt.y - offsetY);
            
            startAngel += angelStep;
        }
    }
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
    
    [btn setTitle:[NSString stringWithFormat:@"%d", _menuItems.count + 1] forState:UIControlStateNormal];
    
    if (aTarget && anAction)
    {
        [btn addTarget:aTarget action:anAction forControlEvents:UIControlEventTouchUpInside];
    }
    
    [self addSubview:btn];
    [_menuItems addObject:btn];
}

@end
