//
//  AppDelegate.m
//  Zhongminyou
//
//  Created by 李发起 on 2020/4/6.
//

#import "AppDelegate.h"
#import "FirstScrollController.h"
#import "LoginViewController.h"
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapLocationKit/AMapLocationKit.h>

@interface AppDelegate ()<AMapLocationManagerDelegate>

@property (nonatomic, strong) AMapLocationManager *locationManager;

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
    // 高德地图
    [AMapServices sharedServices].apiKey = MapAppKey;
}

#pragma mark - 地图定位，进入app后执行一次
-(void)getCurrentLocation{
    self.locationManager = [[AMapLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.distanceFilter = 200;
//    [self.locationManager setLocatingWithReGeocode:YES];
    [self.locationManager startUpdatingLocation];
}

- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location reGeocode:(AMapLocationReGeocode *)reGeocode{
    NSLog(@"location:{lat:%f; lon:%f; accuracy:%f}", location.coordinate.latitude, location.coordinate.longitude, location.horizontalAccuracy);
    if (location) {
        [ToolKit setLocationModelInfo:[LocationModel LocationInfoWithDict:SWYNSStringFromFormat(@"%f",location.coordinate.longitude) andLat:SWYNSStringFromFormat(@"%f",location.coordinate.latitude) andAddress:@""]];
    }
    
    [self.locationManager stopUpdatingLocation];
}

- (void)amapLocationManager:(AMapLocationManager *)manager doRequireLocationAuth:(CLLocationManager*)locationManager{
    [locationManager requestWhenInUseAuthorization];
}

- (void)applicationDidBecomeActive:(UIApplication *)application{
    [self getCurrentLocation];
}

@end
