//
//  AppViewController.m
//  NavJunk
//
//  Created by Brian Michel on 4/23/13.
//  Copyright (c) 2013 Brian Michel. All rights reserved.
//

#import "AppViewController.h"
#import "ButtonNavigationController.h"
#import "ViewController.h"

@interface AppViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong) NSIndexPath *selectedIndexPath;
@property (strong) ButtonNavigationController *option1;
@property (strong) ButtonNavigationController *option2;
@property (strong) ButtonNavigationController *option3;

@property (strong) NSArray *vcArray;
@end

@implementation AppViewController

- (id)init {
    self = [super init];
    if (self) {
        _navigationTable = [[UITableViewController alloc] initWithStyle:UITableViewStyleGrouped];
        _navigationTable.tableView.delegate = self;
        _navigationTable.tableView.dataSource = self;
        
        //option 1 (all hovers)
        ViewController *viewController1 = [[ViewController alloc] init];
        self.option1 = [[ButtonNavigationController alloc] initWithRootViewController:viewController1];
        viewController1.showHamburger = YES;
        self.option1.useHoverBack = YES;
        [self addChildViewController:self.option1];
        
        ViewController *viewController2 = [[ViewController alloc] init];
        self.option2 = [[ButtonNavigationController alloc] initWithRootViewController:viewController2];
        viewController2.showHamburger = YES;
        self.option2.useHoverBack = NO;
        [self addChildViewController:self.option2];
        
        ViewController *viewController3 = [[ViewController alloc] init];
        viewController3.showCart = YES;
        viewController3.cartItem.target = self;
        viewController3.cartItem.action = @selector(showCart:);
        viewController3.showHamburger = YES;
        self.option3 = [[ButtonNavigationController alloc] initWithRootViewController:viewController3];
        self.option3.useHoverBack = NO;
        self.option3.useHoverCart = NO;
        [self addChildViewController:self.option3];
        
        self.vcArray = @[self.option1, self.option2, self.option3];
        
        for (ButtonNavigationController *nav in self.vcArray) {
            [nav.hoverCartButton addTarget:self action:@selector(showCart:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self transitionToViewControllerAtIndex:0];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions
- (void)transitionToViewControllerAtIndex:(NSUInteger)index {
    if ((self.selectedIndexPath &&  self.selectedIndexPath.row == index)) {
        return;
    }
    
    UIViewController *vcToTransitionTo = self.vcArray[index];
    vcToTransitionTo.view.frame = self.view.bounds;
    if (self.selectedIndexPath) {
        UIViewController *vcToTransitionFrom = self.vcArray[self.selectedIndexPath.row];
        [self transitionFromViewController:vcToTransitionFrom toViewController:vcToTransitionTo duration:0.3 options:0 animations:nil completion:nil];
    } else {
        [self.view addSubview:vcToTransitionTo.view];
    }
}

- (void)showCart:(id)sender {
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = [UIColor magentaColor];
    vc.title = @"Cart";
    vc.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(dismissCart:)];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:nav animated:YES completion:nil];
}

- (void)dismissCart:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - TableView Datasource / Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * cellId = @"cellId";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"Option %i", indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //transition
    [self transitionToViewControllerAtIndex:indexPath.row];
    self.selectedIndexPath = indexPath;
}

@end
