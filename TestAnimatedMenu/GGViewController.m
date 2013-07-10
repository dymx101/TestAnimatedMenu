//
//  GGViewController.m
//  TestAnimatedMenu
//
//  Created by Dong Yiming on 7/9/13.
//  Copyright (c) 2013 Dong Yiming. All rights reserved.
//

#import "GGViewController.h"
#import "GGAnimatedMenu.h"

@interface GGViewController ()

@end

@implementation GGViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"%@", NSStringFromCGRect(self.view.frame));
	
    GGAnimatedMenu *menu = [[GGAnimatedMenu alloc] initWithFrame:self.view.bounds];
    
    [menu addItemWithImage:nil selectedImage:nil target:self action:@selector(dummy:)];
    [menu addItemWithImage:nil selectedImage:nil target:self action:@selector(dummy:)];
    [menu addItemWithImage:nil selectedImage:nil target:self action:@selector(dummy:)];
    [menu addItemWithImage:nil selectedImage:nil target:self action:@selector(dummy:)];
    [menu addItemWithImage:nil selectedImage:nil target:self action:@selector(dummy:)];
    [menu addItemWithImage:nil selectedImage:nil target:self action:@selector(dummy:)];
    
    [menu showInView:self.view];
}

-(void)dummy:(id)sender
{
    NSLog(@"button tapped.");
}

@end
