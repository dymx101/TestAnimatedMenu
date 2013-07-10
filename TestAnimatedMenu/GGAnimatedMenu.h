//
//  GGAnimatedMenu.h
//  TestAnimatedMenu
//
//  Created by Dong Yiming on 7/9/13.
//  Copyright (c) 2013 Dong Yiming. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GGAnimatedMenu : UIView
-(void)showInView:(UIView *)aView;
-(void)addButtonWithImage:(UIImage *)aImage selectedImage:(UIImage *)aSelectedImage target:(id)aTarget action:(SEL)anAction;

@end
