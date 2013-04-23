//
//  ButtonNavigationController.m
//  NavJunk
//
//  Created by Brian Michel on 4/19/13.
//  Copyright (c) 2013 Brian Michel. All rights reserved.
//

#import "ButtonNavigationController.h"
#import <QuartzCore/QuartzCore.h>

@interface ButtonNavigationController ()
@end

@implementation ButtonNavigationController

@synthesize useHoverBack = _usesHoverButtons;
@synthesize useHoverCart = _useHoverCart;

- (void)viewDidLoad
{
    [super viewDidLoad];
    _hoverBackButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.hoverBackButton setImage:[UIImage imageNamed:@"icn_back"] forState:UIControlStateNormal];
    [self.hoverBackButton sizeToFit];
    [self.hoverBackButton addTarget:self action:@selector(pushNew:) forControlEvents:UIControlEventTouchUpInside];
    self.hoverBackButton.layer.shadowColor = [UIColor blackColor].CGColor;
    self.hoverBackButton.layer.shadowOffset = CGSizeMake(0, 1);
    self.hoverBackButton.layer.shadowRadius = 1.0;
    self.hoverBackButton.layer.shadowOpacity = 0.7;
    
    _hoverCartButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.hoverCartButton setTitle:@"Cart" forState:UIControlStateNormal];
    [self.hoverCartButton sizeToFit];
    self.hoverCartButton.layer.shadowColor = [UIColor blackColor].CGColor;
    self.hoverCartButton.layer.shadowOffset = CGSizeMake(0, 1);
    self.hoverCartButton.layer.shadowRadius = 1.0;
    self.hoverCartButton.layer.shadowOpacity = 0.7;
    
    self.hoverBackButton.frame = CGRectMake(10, self.view.bounds.size.height - self.hoverBackButton.bounds.size.height - 10, self.hoverBackButton.frame.size.width, self.hoverBackButton.frame.size.height);
    [self.view addSubview:self.hoverBackButton];
    
    self.hoverCartButton.frame = CGRectMake(self.view.bounds.size.width - self.hoverCartButton.frame.size.width - 10, self.hoverBackButton.frame.origin.y, self.hoverCartButton.frame.size.width, self.hoverCartButton.frame.size.height);
    [self.view addSubview:self.hoverCartButton];
	// Do any additional setup after loading the view.
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.hoverBackButton.frame = CGRectMake(10, self.view.bounds.size.height - self.hoverBackButton.bounds.size.height - 10, self.hoverBackButton.frame.size.width, self.hoverBackButton.frame.size.height);
    
    self.hoverCartButton.frame = CGRectMake(self.view.bounds.size.width - self.hoverCartButton.frame.size.width - 10, self.hoverBackButton.frame.origin.y, self.hoverCartButton.frame.size.width, self.hoverCartButton.frame.size.height);
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.useHoverBack) {
        [viewController.navigationItem setHidesBackButton:YES];
    }
    
    [super pushViewController:viewController animated:animated];
    [self checkButton];
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated {
    UIViewController *vcToPop = [super popViewControllerAnimated:animated];
    [self checkButton];
    return vcToPop;
}

#pragma mark - Actions

- (void)checkButton {
    BOOL show =  self.navigationBar.backItem != nil && self.useHoverBack;
    CGFloat alpha = show ? 1.0 : 0.0;
    if (self.hoverBackButton.alpha == alpha) {return;}
    
    [UIView animateWithDuration:0.3 animations:^{
        self.hoverBackButton.alpha = alpha;
    }];
}

- (void)pushNew:(id)sender {
    [self popViewControllerAnimated:YES];
}

#pragma mark - Setters / Getters
- (void)setUseHoverBack:(BOOL)usesHoverButtons {
    _usesHoverButtons = usesHoverButtons;
    
    self.topViewController.navigationItem.leftItemsSupplementBackButton = YES;
    [self.topViewController.navigationItem setHidesBackButton:_usesHoverButtons animated:YES];
    [self checkButton];
}

- (BOOL)useHoverBack {
    return _usesHoverButtons;
}

- (void)setUseHoverCart:(BOOL)useHoverCart {
    _useHoverCart = useHoverCart;
    self.hoverCartButton.hidden = !_useHoverCart;
}

- (BOOL)useHoverCart {
    return _useHoverCart;
}

@end
