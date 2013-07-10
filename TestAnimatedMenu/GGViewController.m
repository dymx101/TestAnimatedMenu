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
	
    GGAnimatedMenu *menu = [[GGAnimatedMenu alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:menu];
}



@end
