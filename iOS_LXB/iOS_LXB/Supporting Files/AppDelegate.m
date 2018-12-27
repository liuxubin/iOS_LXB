//
//  AppDelegate.m
//  iOS_LXB
//
//  Created by 穗金所 on 2018/12/13.
//  Copyright © 2018年 kodbin. All rights reserved.
//

#import "AppDelegate.h"
#import "LXB_FirstViewController.h"
#import "LXB_SecondViewController.h"
#import "LXB_ThirdViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    UITabBarController *tabbarC= [[UITabBarController alloc] init];
    
    self.window.rootViewController = tabbarC;
    LXB_FirstViewController *vc1 = [LXB_FirstViewController new];
    vc1.tabBarItem.image = [UIImage imageNamed:@"dicengjishu"];
    vc1.tabBarItem.selectedImage =  [UIImage imageNamed:@"dicengjishu"];
    LXB_SecondViewController *vc2 = [LXB_SecondViewController new];
    vc2.tabBarItem.image = [UIImage imageNamed:@"ui"];
    vc2.tabBarItem.selectedImage =  [UIImage imageNamed:@"ui"];
    LXB_ThirdViewController*vc3 = [LXB_ThirdViewController new];
    vc3.tabBarItem.image = [UIImage imageNamed:@"qita"];
    vc3.tabBarItem.selectedImage =  [UIImage imageNamed:@"qita"];
    NSMutableArray *arrayVc = [NSMutableArray arrayWithArray:@[vc1,vc2,vc3]];
    for (NSInteger i = 0; i< 3; i++) {
        UINavigationController *navC = [[UINavigationController alloc]initWithRootViewController:arrayVc[i]];
        [tabbarC addChildViewController:navC];
    }
    
    
    
    
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
