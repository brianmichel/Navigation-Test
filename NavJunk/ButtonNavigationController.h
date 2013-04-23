//
//  ButtonNavigationController.h
//  NavJunk
//
//  Created by Brian Michel on 4/19/13.
//  Copyright (c) 2013 Brian Michel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ButtonNavigationController : UINavigationController

@property (strong, readonly) UIButton *hoverBackButton;
@property (strong, readonly) UIButton *hoverCartButton;

@property (assign) BOOL useHoverBack;
@property (assign) BOOL useHoverCart;
@end
