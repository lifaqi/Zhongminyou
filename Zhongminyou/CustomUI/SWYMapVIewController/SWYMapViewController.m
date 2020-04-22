//
//  SWYMapViewController.m
//  Zhongminyou
//
//  Created by 李发起 on 2020/4/13.
//

#import "SWYMapViewController.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>

@interface SWYMapViewController ()<MAMapViewDelegate>

@end

@implementation SWYMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setLeftBtnImg:@"left"];
    [self setRightBtnImg:@"icon-qita"];
    
    [self setUpUI];
}

- (void)clickRightButton:(UIButton *)rightBtn{
    [ToolKit actionSheetView:self andTitle:@"" andMsg:@"跳转到第三方地图" andCancelButtonTitle:@"取消" andOtherButtonTitle:@[@"打开地图"] handler:^(int buttonIndex, UIAlertAction * _Nonnull alertView) {
        if (buttonIndex == 1) {
            [self openMap];
        }
    }];
}

-(void)openMap{
    NSString *urlString;
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"iosamap://"]]) {
        urlString = [NSString stringWithFormat:@"iosamap://viewMap?sourceApplication=%@&poiname=%@&lat=%@&lon=%@&dev=1",@"导航",_titleStr,SWYNSStringFromFormat(@"%f",_lat),SWYNSStringFromFormat(@"%f",_lng)];
    }else if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"baidumap://"]]){
        urlString = [NSString stringWithFormat:@"baidumap://map/marker?location=%f,%f&title=%@",_lat,_lng,_titleStr];
    }else{
        urlString = [NSString stringWithFormat:@"https://uri.amap.com/marker?position=%f,%f&name=%@",_lng, _lat,_titleStr];
    }
    
    NSString * unicodeStr = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [ToolKit openUrl:[NSURL URLWithString:unicodeStr]];
}

#pragma mark - setUpUI
-(void)setUpUI{
    ///初始化地图
    MAMapView *_mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, HeaderHeight, ScreenWidth, ScreenHeight - HeaderHeight)];
    _mapView.delegate = self;
    _mapView.showTraffic = YES; // 是否打开实时交通路况
    _mapView.showsScale = YES; // 设置成 NO 表示不显示比例尺;YES 表示显示比例尺
    _mapView.scaleOrigin = CGPointMake(_mapView.scaleOrigin.x, 22); // 设置比例尺位置
    _mapView.compassOrigin= CGPointMake(_mapView.compassOrigin.x, 22); // 设置指南针位置
    _mapView.zoomLevel = 18;
    _mapView.centerCoordinate = CLLocationCoordinate2DMake(_lat, _lng);
    MACoordinateSpan span = MACoordinateSpanMake(_mapView.region.span.latitudeDelta * 0.8, _mapView.region.span.longitudeDelta * 0.8);
    _mapView.region = MACoordinateRegionMake(CLLocationCoordinate2DMake(_lat, _lng), span);
    

    ///把地图添加至view
    [self.view addSubview:_mapView];
    
    

    ///如果您需要进入地图就显示定位小蓝点，则需要下面两行代码
//    _mapView.showsUserLocation = YES;
//    _mapView.userTrackingMode = MAUserTrackingModeFollow;
    
    MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];//初始化标注
    pointAnnotation.coordinate = CLLocationCoordinate2DMake(_lat, _lng); //设置标注地理坐标
    pointAnnotation.title = _titleStr;//设置标注标题
//    pointAnnotation.subtitle = @"阜通东大街 6 号";//设置标注子标题
    [_mapView addAnnotation:pointAnnotation];//添加标注
}

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
        if ([annotation isKindOfClass:[MAPointAnnotation class]]) {
            static NSString *pointReuseIndetifier = @"pointReuseIndetifier";
            MAPinAnnotationView*annotationView = (MAPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndetifier];
            if (annotationView == nil) {
                annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndetifier];
            }
            annotationView.canShowCallout= YES; //设置气泡可以弹出,默认为 NO
        
            annotationView.animatesDrop = YES; //设置标注动画显示,默认为 NO

            annotationView.draggable = YES; //设置标注可以拖动,默认为 NO annotationView.pinColor = MAPinAnnotationColorPurple;
            return annotationView;
        }
        return nil;
    
        
}

@end
