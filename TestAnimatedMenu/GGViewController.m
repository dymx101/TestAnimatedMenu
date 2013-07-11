//
//  GGViewController.m
//  TestAnimatedMenu
//
//  Created by Dong Yiming on 7/9/13.
//  Copyright (c) 2013 Dong Yiming. All rights reserved.
//

#import "GGViewController.h"
#import "GGAnimatedMenu.h"

#define MENU_TAG        (20130711)

@interface GGViewController ()

@end

@implementation GGViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    NSLog(@"%@", NSStringFromCGRect(self.view.frame));
	
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Show Menu" style:UIBarButtonItemStyleBordered target:self action:@selector(showMenu)];
}

-(void)showMenu
{
    GGAnimatedMenu *menu = [[GGAnimatedMenu alloc] initWithFrame:self.view.bounds];

    menu.menuItemRadious = 53.f;
    menu.menuRadious = 70.f;
    
    __weak GGAnimatedMenu *menuShadow = menu;
    
    [menu addItemWithImage:[UIImage imageNamed:@"share_chatter"] selectedImage:nil action:^{
        NSLog(@"share chatter");
        [menuShadow dismiss];
    }];
    
    [menu addItemWithImage:[UIImage imageNamed:@"share_linkedin"] selectedImage:nil action:^{
        NSLog(@"share linkedIn");
        [menuShadow dismiss];
    }];
    
    [menu addItemWithImage:[UIImage imageNamed:@"share_twitter"] selectedImage:nil action:^{
        NSLog(@"share twitter");
        [menuShadow dismiss];
    }];
    
    [menu addItemWithImage:[UIImage imageNamed:@"share_facebook"] selectedImage:nil action:^{
        NSLog(@"share facebook");
        [menuShadow dismiss];
    }];
    
    [menu addItemWithImage:[UIImage imageNamed:@"share_mail"] selectedImage:nil action:^{
        NSLog(@"share mail");
        [menuShadow dismiss];
    }];
    
    [menu addItemWithImage:[UIImage imageNamed:@"share_message"] selectedImage:nil action:^{
        NSLog(@"share message");
        [menuShadow dismiss];
    }];
    
    [menu showInView:self.view];
}

-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    CGRect futureRect = [UIScreen mainScreen].bounds;
    NSLog(@"screen rect:%@", NSStringFromCGRect(futureRect));
    
    float min = MIN(futureRect.size.width, futureRect.size.height);
    float max = MAX(futureRect.size.width, futureRect.size.height);
    
    BOOL willRotateToPotrait = UIInterfaceOrientationIsPortrait(toInterfaceOrientation);
    float deduction = 20 + (willRotateToPotrait ? 44 : 32);
    futureRect = willRotateToPotrait ? CGRectMake(0, 0, min, max) : CGRectMake(0, 0, max, min);
    futureRect.size.height -= deduction;
    NSLog(@"future rect:%@, deduction:%f", NSStringFromCGRect(futureRect), deduction);
    
    GGAnimatedMenu *menu = (GGAnimatedMenu *)[self.view viewWithTag:[GGAnimatedMenu tag]];
    [menu relayoutToFitRect:futureRect];
}

@end
