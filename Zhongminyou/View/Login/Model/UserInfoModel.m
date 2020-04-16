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
            self.access_token = [ToolKit dealWithString:dict[@"data"]];
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
-(instancetype)initWithCoder:(NSCoder *)decoder{
    self = [super init];
    if (self) {
        self.access_token = [decoder decodeObjectOfClass:[NSString class] forKey:@"access_token"];
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder{
    [encoder encodeObject:self.access_token forKey:@"access_token"];
}

+ (BOOL)supportsSecureCoding{
    return YES;
}

@end
