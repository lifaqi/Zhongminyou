//
//  IndexLunbotuTableViewCell.h
//  Zhongminyou
//
//  Created by 李发起 on 2020/4/8.
//

#import <UIKit/UIKit.h>
#import "SDCycleScrollView.h"
#import "DropDownMenu.h"

NS_ASSUME_NONNULL_BEGIN

typedef void (^IndexLunbotuClickBlock) (NSInteger index, NSInteger tag);

@interface IndexLunbotuTableViewCell : UITableViewCell

@property (nonatomic, strong) NSArray *imagesURLStringsArray;
@property (nonatomic, assign) CGFloat frameHeight;
@property (nonatomic, assign) SDCycleScrollViewPageContolAliment pageContolAliment;
@property (nonatomic, copy) IndexLunbotuClickBlock indexLunbotuClickBlock;

+ (CGFloat)getCellHeight;

@end

NS_ASSUME_NONNULL_END