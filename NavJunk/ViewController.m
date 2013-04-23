//
//  ViewController.m
//  NavJunk
//
//  Created by Brian Michel on 4/19/13.
//  Copyright (c) 2013 Brian Michel. All rights reserved.
//

#import "ViewController.h"
#import "ButtonNavigationController.h"

@interface ViewController ()
@property (strong) UIButton *button;
@property (strong) UIBarButtonItem *searchButton;
@end

@implementation ViewController

@synthesize showCart = _showCart;
@synthesize showHamburger = _showHamburger;

- (id)init {
    self = [super init];
    if (self) {
        _cartItem = [[UIBarButtonItem alloc] initWithTitle:@"Cart" style:UIBarButtonItemStyleBordered target:nil action:nil];
        self.searchButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:nil action:nil];
        self.showCart = NO;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Controller";
    
    self.view.backgroundColor = [UIColor colorWithHue:(arc4random() % 256) / 256.0 saturation:81.0 / 256.0 brightness:1.0 alpha:1.0];
    
    self.button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.button setTitle:@"Push New View" forState:UIControlStateNormal];
    [self.button  addTarget:self action:@selector(pushNew:) forControlEvents:UIControlEventTouchUpInside];
    [self.button sizeToFit];
    [self.view addSubview:self.button];
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.button.frame = CGRectMake(round(self.view.frame.size.width/2 - self.button.frame.size.width/2), round(self.view.frame.size.height/2 - self.button.frame.size.height/2), self.button.frame.size.width, self.button.frame.size.height);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pushNew:(id)sender {
    ViewController *vc = [[ViewController alloc] init];
    ButtonNavigationController *nav = (ButtonNavigationController *)self.navigationController;
    vc.showHamburger = self.showHamburger && nav.useHoverBack;
    vc.showCart = self.showCart;
    vc.cartItem.target = self.cartItem.target;
    vc.cartItem.action = self.cartItem.action;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)reveal:(id)sender {
    [self.sidePanelController showLeftPanelAnimated:YES];
}

#pragma mark - Setters / Getters
- (void)setShowCart:(BOOL)showCart {
    _showCart = showCart;
    self.navigationItem.rightBarButtonItems = _showCart ? @[_cartItem, self.searchButton] : @[self.searchButton];
}

- (BOOL)showCart {
    return _showCart;
}

- (void)setShowHamburger:(BOOL)showHamburger {
    _showHamburger = showHamburger;
    if (_showHamburger) {
        UIBarButtonItem *hamburger = [[UIBarButtonItem alloc] initWithImage:[JASidePanelController defaultImage] style:UIBarButtonItemStyleBordered target:self action:@selector(reveal:)];
        self.navigationItem.leftItemsSupplementBackButton = NO;
        self.navigationItem.leftBarButtonItem = hamburger;
    } else {
        self.navigationItem.leftBarButtonItem = nil;
        self.navigationItem.leftItemsSupplementBackButton = YES;
    }
}

- (BOOL)showHamburger {
    return _showHamburger;
}
@end
