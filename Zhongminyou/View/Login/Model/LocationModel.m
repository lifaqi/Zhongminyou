//
//  LocationModel.m
//  Zhongminyou
//
//  Created by 李发起 on 2020/4/13.
//

#import "LocationModel.h"

@implementation LocationModel

+(instancetype)LocationInfoWithDict:(NSString *)lng andLat:(NSString *)lat andAddress:(NSString *)address{
    return [[self alloc] initWithDict:lng andLat:lat andAddress:address];
}

-(instancetype)initWithDict:(NSString *)lng andLat:(NSString *)lat andAddress:(NSString *)address{
    self = [super init];
    if (self) {
        @try {
            self.lng = lng;
            self.lat = lat;
            self.address = address;
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
        self.lng = [decoder decodeObjectOfClass:[NSString class] forKey:@"lng"];
        self.lat = [decoder decodeObjectOfClass:[NSString class] forKey:@"lat"];
        self.address = [decoder decodeObjectOfClass:[NSString class] forKey:@"address"];
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder{
    [encoder encodeObject:self.lng forKey:@"lng"];
    [encoder encodeObject:self.lat forKey:@"lat"];
    [encoder encodeObject:self.address forKey:@"address"];
}

+ (BOOL)supportsSecureCoding{
    return YES;
}

@end
