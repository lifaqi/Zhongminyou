//
//  AccountInfoModel.h
//  Zhongminyou
//
//  Created by 李发起 on 2020/4/11.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AccountInfoModel : NSObject<NSSecureCoding>

@property (nonatomic, strong) NSString *account;
@property (nonatomic, strong) NSString *password;

+(instancetype)AccountInfoWithDict:(NSString *)account andPassword:(NSString *)password;

@end

NS_ASSUME_NONNULL_END
