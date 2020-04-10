//
//  RecommendTitleTableViewCell.h
//  Zhongminyou
//
//  Created by 李发起 on 2020/4/9.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^RecommendMoreCallBack) (void);

@interface RecommendTitleTableViewCell : UITableViewCell

@property (nonatomic, strong) NSString *titleStr;
@property (nonatomic, assign) BOOL hiddenMore;
@property (nonatomic, copy) RecommendMoreCallBack recommendMoreCallBack;

+ (CGFloat)getCellHeight;

@end

NS_ASSUME_NONNULL_END
