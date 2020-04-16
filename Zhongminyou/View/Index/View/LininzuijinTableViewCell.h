//
//  LininzuijinTableViewCell.h
//  Zhongminyou
//
//  Created by 李发起 on 2020/4/11.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^LijijiayouCallBack) (void);
typedef void (^DingweiCallBack) (CGFloat lng, CGFloat lat, NSString *titleStr);

@interface LininzuijinTableViewCell : UITableViewCell

@property (nonatomic, copy) LijijiayouCallBack lijijiayouCallBack;
@property (nonatomic, copy) DingweiCallBack dingweiCallBack;
@property (nonatomic, strong) NSDictionary *gasDict;

#pragma mark - func
+ (CGFloat)getCellHeight;

@end

NS_ASSUME_NONNULL_END
