//
//  AppDelegate.m
//  megerPictureVideo
//
//  Created by 1 on 2020/11/12.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    [self.window resignKeyWindow];
    ViewController *vc = [[ViewController alloc]initWithNibName:@"ViewController" bundle:nil];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
    self.window.rootViewController = nav;
    // Override point for customization after application launch.
    return YES;
}



@end
