//
//  RecommendItemTableViewCell.h
//  Zhongminyou
//
//  Created by 李发起 on 2020/4/9.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^DingweiCallBack) (CGFloat lng, CGFloat lat, NSString *titleStr);

@interface RecommendItemTableViewCell : UITableViewCell

@property (nonatomic, strong) NSDictionary *gasDataDict;
@property (nonatomic, copy) DingweiCallBack dingweiCallBack;

+ (CGFloat)getCellHeight;

@end

NS_ASSUME_NONNULL_END
