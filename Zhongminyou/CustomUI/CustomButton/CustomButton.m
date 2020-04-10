//
//  CustomButton.m
//  Moyu
//
//  Created by Rain on 5/2/17.
//  Copyright © 2017 zykj. All rights reserved.
//

#import "CustomButton.h"

#define ImageRatio 0.5  // 图片占整个按钮高度的比例

@implementation CustomButton{
    /**
     * 1：上下，图片上，文字下  2：左右，图片做，文字右
     */
    int iFlag;
}

// 上下。图片上，文字下
-(instancetype)initWithFrame:(CGRect)rect{
    if (self == [super initWithFrame:rect]){
        iFlag = 1;
        [self initView];
    }
    return self;
}

// 左右。图片左，文字右
-(instancetype)initWithFrameLeftRight:(CGRect)rect{
    if (self == [super initWithFrame:rect]){
        iFlag = 2;
        [self initView];
    }
    return self;
}

// 左右。图片右，文字左
-(instancetype)initWithFrameLeftRight:(CGRect)rect andIsLeft:(BOOL)isLeft{
    if (self == [super initWithFrame:rect]){
        if (isLeft) {
            iFlag = 2;
        }else{
            iFlag = 3;
        }
        [self initView];
    }
    return self;
}

// 左右。图片左，title、detail右边上下显示
-(instancetype)initWithFrameTitleDetail:(CGRect)rect andImageUrlString:(NSString *)imageUrlString andTitle:(NSString *)title andDetail:(NSString *)detail{
    if (self == [super initWithFrame:rect]){
        iFlag = 4;
        [self initView];
        [self.showIv sd_setImageWithURL:[NSURL URLWithString:imageUrlString] placeholderImage:[UIImage imageNamed:@"taohuo"]];
        self.titleLbl.text = title;
        self.detailLbl.text = detail;
    }
    return self;
}

// 左右。图片左，title、detail右边上下显示
-(instancetype)initWithFrameTitleDetail:(CGRect)rect andImageName:(NSString *)imageName andTitle:(NSString *)title andDetail:(NSString *)detail{
    if (self == [super initWithFrame:rect]){
        iFlag = 4;
        [self initView];
        self.showIv.image = [UIImage imageNamed:imageName];
        self.titleLbl.text = title;
        self.detailLbl.text = detail;
    }
    return self;
}

#pragma mark - initView
-(void)initView{
    if (iFlag == 1) {
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:16];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.userInteractionEnabled = false;
    }else if (iFlag == 2){
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        self.titleLabel.textAlignment = NSTextAlignmentLeft;
        self.titleLabel.font = [UIFont systemFontOfSize:16];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.userInteractionEnabled = false;
    }else if (iFlag == 3){
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        self.titleLabel.textAlignment = NSTextAlignmentRight;
        self.titleLabel.font = [UIFont systemFontOfSize:16];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.userInteractionEnabled = false;
    }else{
        [self addSubview:self.showIv];
        [self addSubview:self.titleLbl];
        [self addSubview:self.detailLbl];
        self.userInteractionEnabled = false;
    }
}

-(CGRect)imageRectForContentRect:(CGRect)contentRect{
    if (iFlag == 1) {
        return CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - 21 - 5 * 2);
    }else if (iFlag == 3){
        return CGRectMake(self.frame.size.width - self.frame.size.height - 5, 0, self.frame.size.height, self.frame.size.height);
    }else{
        return CGRectMake(0, 0, self.frame.size.height, self.frame.size.height);
    }
}

-(CGRect)titleRectForContentRect:(CGRect)contentRect{
    if (iFlag == 1) {
        return CGRectMake(0, self.frame.size.height - 5 - 21, self.frame.size.width, 21);
    }else if (iFlag == 3){
        return CGRectMake(0, 0, self.frame.size.width - self.frame.size.height - 10, self.frame.size.height);
    }else{
        return CGRectMake(self.frame.size.height + 8, 0, self.frame.size.width - self.frame.size.height, self.frame.size.height);
    }
}

#pragma mark - 属性
-(UIImageView *)showIv{
    if (!_showIv){
        _showIv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.height, self.frame.size.height)];
        _showIv.contentMode = UIViewContentModeScaleToFill;
    }
    return _showIv;
}

-(UILabel *)titleLbl{
    if (!_titleLbl) {
        _titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.showIv.frame) + 8, CGRectGetMinY(self.showIv.frame) + CGRectGetHeight(self.showIv.frame) / 2 - 21, self.frame.size.width - CGRectGetMaxX(self.showIv.frame) - 5, 21)];
        _titleLbl.font = [UIFont systemFontOfSize:16];
    }
    return _titleLbl;
}

-(UILabel *)detailLbl{
    if (!_detailLbl) {
        _detailLbl = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.showIv.frame) + 8, CGRectGetMaxY(self.titleLbl.frame), self.frame.size.width - CGRectGetMaxX(self.showIv.frame) - 5, 21)];
        _detailLbl.textColor = [UIColor grayColor];
        _detailLbl.font = [UIFont systemFontOfSize:12];
    }
    return _detailLbl;
}

@end
