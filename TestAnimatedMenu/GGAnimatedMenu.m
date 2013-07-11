//
//  GGAnimatedMenu.m
//  TestAnimatedMenu
//
//  Created by Dong Yiming on 7/9/13.
//  Copyright (c) 2013 Dong Yiming. All rights reserved.
//

#import "GGAnimatedMenu.h"
#import <QuartzCore/QuartzCore.h>

#define DEFAULT_BUTTON_SIZE             (40.f)
#define DEFAULT_CIRCLE_RADIOUS_NEAR     (80.f)

#define BUTTON_TAG_BASE                 (1000);

static BOOL __isShowing = NO;

@implementation GGAnimatedMenu
{
    NSMutableArray      *_menuItems;
    NSMutableArray      *_actions;
    
    UIView              *_dimedView;
    UIView              *_rotateView;
}

+(BOOL)isShowing
{
    return __isShowing;
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
    _menuRadious = DEFAULT_CIRCLE_RADIOUS_NEAR;
    _menuItemRadious = DEFAULT_BUTTON_SIZE;
    
    _menuItems = [NSMutableArray array];
    _actions = [NSMutableArray array];
    
    _dimedView = [[UIView alloc] initWithFrame:self.bounds];
    _dimedView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _dimedView.backgroundColor = [UIColor blackColor];
    _dimedView.layer.opacity = .5f;
    [self addSubview:_dimedView];
    
    _rotateView = [[UIView alloc] initWithFrame:self.bounds];
    _rotateView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    //_rotateView.backgroundColor = [UIColor clearColor];
    //_rotateView.layer.opacity = .5f;
    [self addSubview:_rotateView];
    
    UITapGestureRecognizer *tapToDissmiss = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
    [self addGestureRecognizer:tapToDissmiss];
}

-(void)showInView:(UIView *)aView
{
    if (__isShowing) return;
    __isShowing = YES;
    
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
        [self _arrangeButtonsWithRadious:[self _maxMenuRadious]];
        _rotateView.transform = CGAffineTransformMakeRotation(-M_PI);
        //
        [UIView animateWithDuration:.2f animations:^{
            
            [self _arrangeButtonsWithRadious:_menuRadious];
            self.alpha = 1.f;
            
            
        } completion:^(BOOL finished) {
            
            [UIView animateWithDuration:1.f delay:0.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
                _rotateView.transform = CGAffineTransformIdentity;
            } completion:nil];
        }];
    }
    
    [aView addSubview:self];
}

-(float)_maxMenuRadious
{
    CGSize thisSize = self.frame.size;
    return MAX(thisSize.width, thisSize.height) + _menuItemRadious;
}

-(void)dismiss
{
    [UIView animateWithDuration:.2f animations:^{
        
        [self _arrangeButtonsWithRadious:[self _maxMenuRadious]];
        self.alpha = .3f;
        
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        __isShowing = NO;
    }];
}

-(void)relayoutToFitRect:(CGRect)aRect
{
    if (self.superview)
    {
        [self.layer removeAllAnimations];
        
        self.frame = aRect;
        [self _arrangeButtonsWithRadious:_menuRadious];
    }
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
            float offsetX = aRadious * cos(startAngel);
            float offsetY = aRadious * sin(startAngel);
            
            //NSLog(@"center:%@, radious:%f, angel:%f, size:%f, offsetX:%f, offsetY:%f", NSStringFromCGPoint(centerPt), DEFAULT_CIRCLE_RADIOUS, (startAngel * 180 / M_PI), DEFAULT_BUTTON_SIZE, offsetX, offsetY);
            
            UIButton *theBtn = _menuItems[i];
            theBtn.center = CGPointMake(centerPt.x - offsetX, centerPt.y - offsetY);
            
            startAngel += angelStep;
        }
    }
}

-(UIButton *)addItemWithImage:(UIImage *)aImage selectedImage:(UIImage *)aSelectedImage action:(GGAnimatedMenuAction)anAction
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, _menuItemRadious, _menuItemRadious);
    btn.layer.cornerRadius = _menuItemRadious / 2;
    btn.backgroundColor = [UIColor blackColor];
    //btn.layer.opacity = .5f;
    [btn setImage:aImage forState:UIControlStateNormal];
    [btn setImage:aSelectedImage forState:UIControlStateSelected | UIControlStateHighlighted];
    
    btn.tag = _menuItems.count + BUTTON_TAG_BASE;
    //[btn setTitle:[NSString stringWithFormat:@"%d", _menuItems.count + 1] forState:UIControlStateNormal];
    
    [btn addTarget:self action:@selector(menuItemTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    [_actions addObject:(anAction ? [anAction copy] : [NSNull null])];
    
    [_rotateView addSubview:btn];
    [_menuItems addObject:btn];
    
    return btn;
}

-(void)menuItemTapped:(id)sender
{
    int index = ((UIButton *)sender).tag - BUTTON_TAG_BASE;
    GGAnimatedMenuAction action = _actions[index];
    
    if (![action isKindOfClass:[NSNull class]])
    {
        action();
    }
}

@end
