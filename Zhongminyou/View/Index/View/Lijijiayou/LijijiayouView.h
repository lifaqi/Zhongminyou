//
//  LijijiayouView.h
//  Zhongminyou
//
//  Created by 李发起 on 2020/4/11.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^LijiPayCallBack) (NSDictionary *dict, NSString *youpin, NSString *youhao, NSString *amount, NSString *price, NSString *youji, NSString *youqiang);
typedef void (^DingweiCallBack) (CGFloat lng, CGFloat lat, NSString *titleStr);

@interface LijijiayouView : UIView

@property (nonatomic, copy) LijiPayCallBack lijiPayCallBack;
@property (nonatomic, strong) NSDictionary *gasDict;
@property (nonatomic, copy) DingweiCallBack dingweiCallBack;
@property (nonatomic, strong) NSString *youhao;;

#pragma mark - func
-(void)show;

-(void)hidden;

@end

NS_ASSUME_NONNULL_END
