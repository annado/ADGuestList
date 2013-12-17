//
//  ADAppDelegate.m
//  ADGuestList
//
//  Created by Anna Do on 10/8/13.
//  Copyright (c) 2013 ADT. All rights reserved.
//

#import "ADAppDelegate.h"
#import "ADItemsViewController.h"
#import "TestFlight.h"
#import "ADGuestStore.h"

@implementation ADAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [TestFlight takeOff:@"b4f771ce-3ab0-4be0-aa56-1f60e72665c4"];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    // Create a ItemsViewController
    ADItemsViewController *itemsViewController = [[ADItemsViewController alloc] init];

    // Create instance of UINavigationController
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:itemsViewController];
    [[self window] setRootViewController:navController];

    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];

    
    return YES;
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
    BOOL success = [ADGuestStore.sharedStore saveChanges];
    if (success) {
        NSLog(@"Saved all ADGuestItems");
    } else {
        NSLog(@"Could not save any of the ADGuestItems");
    }
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
