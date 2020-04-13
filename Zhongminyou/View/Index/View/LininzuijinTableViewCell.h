//
//  LininzuijinTableViewCell.h
//  Zhongminyou
//
//  Created by 李发起 on 2020/4/11.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^LijijiayouCallBack) (void);

@interface LininzuijinTableViewCell : UITableViewCell

@property (nonatomic, copy) LijijiayouCallBack lijijiayouCallBack;

#pragma mark - func
+ (CGFloat)getCellHeight;

@end

NS_ASSUME_NONNULL_END
