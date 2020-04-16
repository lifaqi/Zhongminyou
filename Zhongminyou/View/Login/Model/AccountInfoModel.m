//
//  AccountInfoModel.m
//  Zhongminyou
//
//  Created by 李发起 on 2020/4/11.
//

#import "AccountInfoModel.h"

@interface AccountInfoModel()

@end

@implementation AccountInfoModel

+ (instancetype)AccountInfoWithDict:(NSString *)account andPassword:(NSString *)password{
    return [[self alloc] initWithDict:account andPassword:password];
}

-(instancetype)initWithDict:(NSString *)account andPassword:(NSString *)password{
    self = [super init];
    if (self) {
        @try {
            self.account = account;
            self.password = password;
        } @catch (NSException *exception) {
            
        } @finally {
            
        }
    }
    return self;
}

/*
 * 自定义的对象 无法直接写入到userdefault中 需要转化为 nsdata 这时需要实现下面两个方法
 */

-(instancetype)initWithCoder:(NSCoder *)decoder{
    self = [super init];
    if (self) {
        self.account = [decoder decodeObjectOfClass:[NSString class] forKey:@"account"];
        self.password = [decoder decodeObjectOfClass:[NSString class] forKey:@"password"];
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder{
    [encoder encodeObject:self.account forKey:@"account"];
    [encoder encodeObject:self.password forKey:@"password"];
}

+ (BOOL)supportsSecureCoding{
    return YES;
}

@end
