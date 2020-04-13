//
//  UserInfoModel.m
//  Zhongminyou
//
//  Created by 李发起 on 2020/4/11.
//

#import "UserInfoModel.h"

@implementation UserInfoModel

+(instancetype)UserInfoWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}

-(instancetype)initWithDict:(NSDictionary *)dict{
    self = [super init];
    if (self) {
        @try {
            self.nickName = dict[@""];
        }
        @catch (NSException *exception) {
            
        }
        @finally{
            
        }
    }
    
    return self;
}

/*
 * 自定义的对象 无法直接写入到userdefault中 需要转化为 nsdata 这时需要实现下面两个方法
 */
- (void)encodeWithCoder:(NSCoder *)coder{
    [coder encodeObject:self.nickName forKey:@"nickName"];
}


-(instancetype)initWithCoder:(NSCoder *)coder{
    self.nickName = [[coder decodeObjectForKey:@"nickName"] copy];

    return self;
}

@end
