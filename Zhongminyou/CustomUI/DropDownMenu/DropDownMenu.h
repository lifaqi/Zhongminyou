//
//  DropDownMenu.h
//  Zhongminyou
//
//  Created by 李发起 on 2020/4/8.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^ClickItemEvent)(NSInteger index);

@interface DropDownMenu : UIView

@property (nonatomic, strong) NSArray *itemArray;
@property (nonatomic, assign) float topValue;
@property (nonatomic, copy) ClickItemEvent clickItemEvent;
@property (nonatomic, assign) NSInteger selectIndex;
@property (nonatomic, strong) DropDownMenu *dropDownMenu;

@end

NS_ASSUME_NONNULL_END
