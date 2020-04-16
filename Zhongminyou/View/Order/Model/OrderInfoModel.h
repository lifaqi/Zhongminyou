//
//  OrderInfoModel.h
//  Zhongminyou
//
//  Created by 李发起 on 2020/4/15.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface OrderInfoModel : NSObject

@property (nonatomic, strong) NSString *gasId;
@property (nonatomic, strong) NSString *gasName;
@property (nonatomic, strong) NSString *youpin;
@property (nonatomic, strong) NSString *youhao;
@property (nonatomic, strong) NSString *shengshu;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *youji;
@property (nonatomic, strong) NSString *youqiang;
@property (nonatomic, strong) NSString *total;

@end

NS_ASSUME_NONNULL_END
