//
//  OrderDetailViewController.h
//  Zhongminyou
//
//  Created by 李发起 on 2020/4/10.
//

#import "BaseNavigationController.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, OrderType) {
    OrderTypeNoPay,
    OrderTypePay
};

@interface OrderDetailViewController : BaseNavigationController

@property (nonatomic, assign) OrderType orderType;

@end

NS_ASSUME_NONNULL_END
