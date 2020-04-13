//
//  AppDelegate.m
//  Zhongminyou
//
//  Created by 李发起 on 2020/4/6.
//

#import "AppDelegate.h"
#import "FirstScrollController.h"
#import "LoginViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [self initConfiguration:launchOptions];
    
    if (self.window == nil) {
        self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    }
    
    if ([ToolKit isLogin]) {
        FirstScrollController *firstSC = [[FirstScrollController alloc] init];
        self.window.rootViewController = firstSC;
    } else {
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        UINavigationController *loginNC = [[UINavigationController alloc] initWithRootViewController:loginVC];
        loginNC.navigationBar.hidden = YES;
        self.window.rootViewController = loginNC;
    }
    
    [self.window makeKeyAndVisible];
    
    NSLog(@"width:%f",[[UIScreen mainScreen] currentMode].size.width);
    NSLog(@"height:%f",[[UIScreen mainScreen] currentMode].size.height);
    
    return YES;
}


#pragma mark - 第三方配置信息
- (void)initConfiguration:(NSDictionary *)launchOptions{
    
}


@end
