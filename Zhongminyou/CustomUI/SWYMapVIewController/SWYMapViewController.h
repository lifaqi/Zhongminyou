//
//  SWYMapViewController.h
//  Zhongminyou
//
//  Created by 李发起 on 2020/4/13.
//

#import "BaseNavigationController.h"

NS_ASSUME_NONNULL_BEGIN

@interface SWYMapViewController : BaseNavigationController

@property (nonatomic, assign) float lng;
@property (nonatomic, assign) float lat;
@property (nonatomic, strong) NSString *titleStr;

@end

NS_ASSUME_NONNULL_END
