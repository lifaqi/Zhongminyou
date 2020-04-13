//
//  UserInfoModel.h
//  Zhongminyou
//
//  Created by 李发起 on 2020/4/11.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserInfoModel : NSObject

@property (nonatomic, strong) NSString *nickName;

+(instancetype)UserInfoWithDict:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
