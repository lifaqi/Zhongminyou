//
//  LijijiayouView.h
//  Zhongminyou
//
//  Created by 李发起 on 2020/4/11.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^LijiPayCallBack) (void);

@interface LijijiayouView : UIView

@property (nonatomic, copy) LijiPayCallBack lijiPayCallBack;

#pragma mark - func
-(void)show;

-(void)hidden;

@end

NS_ASSUME_NONNULL_END
