//
//  OrderDetailTableViewCell.h
//  Zhongminyou
//
//  Created by 李发起 on 2020/4/10.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OrderDetailTableViewCell : UITableViewCell

@property (nonatomic, strong) NSString *titleString;
@property (nonatomic, strong) NSString *valueString;

#pragma mark - func
+ (CGFloat)getCellHeight;

@end

NS_ASSUME_NONNULL_END
