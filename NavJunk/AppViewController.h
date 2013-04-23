//
//  AppViewController.h
//  NavJunk
//
//  Created by Brian Michel on 4/23/13.
//  Copyright (c) 2013 Brian Michel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppViewController : UIViewController
@property (strong, readonly) UITableViewController *navigationTable;

- (void)transitionToViewControllerAtIndex:(NSUInteger)index;
@end
