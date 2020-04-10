//
//  GasLunbotuTableViewCell.h
//  Zhongminyou
//
//  Created by 李发起 on 2020/4/9.
//

#import <UIKit/UIKit.h>
#import "SDCycleScrollView.h"

NS_ASSUME_NONNULL_BEGIN

typedef void (^GasLunbotuCallBack) (NSInteger index, NSInteger tag);

@interface GasLunbotuTableViewCell : UITableViewCell

@property (nonatomic, strong) NSArray *imagesURLStringsArray;
@property (nonatomic, copy) GasLunbotuCallBack gasLunbotuCallBack;

+ (CGFloat)getCellHeight;

@end

NS_ASSUME_NONNULL_END
