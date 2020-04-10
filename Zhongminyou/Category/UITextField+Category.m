//
//  UITextField+Category.m
//  Wenshen
//
//  Created by Rain on 17/8/21.
//  Copyright © 2017年 zykj. All rights reserved.
//

#import "UITextField+Category.h"

@implementation UITextField (Category)

// leftPadding
-(void)setLeftPadding:(CGFloat)leftPadding{
    // leftPaddingView
    UIView *leftPaddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, leftPadding, 0)];
    self.leftView = leftPaddingView;
    self.leftViewMode = UITextFieldViewModeAlways;
}

-(CGFloat)leftPadding{
    return self.leftPadding;
}

// rightPadding
-(void)setRightPadding:(CGFloat)rightPadding{
    // rightPaddingView
    UIView *rightPaddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, rightPadding, 0)];
    self.leftView = rightPaddingView;
    self.leftViewMode = UITextFieldViewModeAlways;
}

-(CGFloat)rightPadding{
    return self.rightPadding;
}

@end
