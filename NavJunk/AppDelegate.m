//
//  AppDelegate.m
//  NavJunk
//
//  Created by Brian Michel on 4/19/13.
//  Copyright (c) 2013 Brian Michel. All rights reserved.
//

#import "AppDelegate.h"

#import "ButtonNavigationController.h"
#import "AppViewController.h"

@interface AppDelegate ()
@property (strong) JASidePanelController *revealController;
@property (strong) AppViewController *appViewController;
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.appViewController = [[AppViewController alloc] init];
    
    self.revealController = [[JASidePanelController alloc] init];
    self.revealController.shouldResizeLeftPanel = YES;
    self.revealController.centerPanel = self.appViewController;
    self.revealController.panningLimitedToTopViewController = NO;
    self.revealController.leftPanel = self.appViewController.navigationTable;
    self.window.rootViewController = self.revealController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)showCart:(id)sender {
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = [UIColor magentaColor];
    vc.title = @"Cart";
    vc.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(dismissCart:)];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    [self.window.rootViewController presentViewController:nav animated:YES completion:nil];
}

- (void)dismissCart:(id)sender {
    [self.window.rootViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
