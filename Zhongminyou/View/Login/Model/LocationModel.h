//
//  LocationModel.h
//  Zhongminyou
//
//  Created by 李发起 on 2020/4/13.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LocationModel : NSObject<NSSecureCoding>

@property (nonatomic, strong) NSString *lng;
@property (nonatomic, strong) NSString *lat;
@property (nonatomic, strong) NSString *address;

+(instancetype)LocationInfoWithDict:(NSString *)lng andLat:(NSString *)lat andAddress:(NSString *)address;

@end

NS_ASSUME_NONNULL_END
