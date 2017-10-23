//
//  MWShieldContentMaskView.m
//  Cafei17-720
//
//  Created by cafei on 2017/8/22.
//  Copyright © 2017年 cafei. All rights reserved.
//

#import "MWShieldContentMaskView.h"

@interface MWShieldContentMaskView ()

@property (nonatomic, strong) UIImageView *bgview;
@property (nonatomic, strong) UIView *infoView;
@property (nonatomic, strong) UIImageView *infoBg;
@property (nonatomic, strong) UIImageView *hornImgView;
@property (nonatomic, strong) NSMutableArray *btnList;

@end

@implementation MWShieldContentMaskView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.bgview = [[UIImageView alloc] initWithFrame:frame];
        self.bgview.backgroundColor = [UIColor blackColor];
        self.bgview.alpha = 0.5;
        [self addSubview:self.bgview];
        
        self.infoView = [[UIView alloc] initWithFrame:CGRectMake(15, 0, CGRectGetWidth(frame)-15*2, 235)];
        [self addSubview:self.infoView];
        
        self.infoBg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.infoView.frame), CGRectGetHeight(self.infoView.frame))];
        self.infoBg.backgroundColor = [UIColor whiteColor];
        self.infoBg.layer.cornerRadius = 7;
        [self.infoView addSubview:self.infoBg];
        
        self.hornImgView = [[UIImageView alloc] init];
        self.hornImgView.image = [UIImage imageNamed:@"MWC_horn.png"];
        [self.infoView addSubview:self.hornImgView];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 19, CGRectGetWidth(self.infoView.frame), 16)];
        titleLabel.text = @"选择理由，可精准屏蔽（可多选）";
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [titleLabel setFont:[UIFont systemFontOfSize:15]];
        [titleLabel setTextColor:[UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1]];
        [self.infoView addSubview:titleLabel];
        
        NSArray *reasonList = @[@"推荐单一",@"重复推荐",@"内容低俗",@"标题夸张",@"广告软文",@"页面出错"];
        float btnSpace = 10;
        float btnWidth = (CGRectGetWidth(self.infoView.frame)-btnSpace*3)/2;
        float btnHeight = 35;
        float btnMaxY = 0;
        self.btnList = [[NSMutableArray alloc] init];
        for (int i = 0; i< 6; i++)
        {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(btnSpace+(btnSpace+btnWidth)*(i%2), CGRectGetMaxY(titleLabel.frame)+17+(12+btnHeight)*(i/2), btnWidth, btnHeight);
            btn.tag = i;
            [btn setTitle:reasonList[i] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1] forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:15];
            [btn setTitleColor:[UIColor colorWithRed:0.0/255.0 green:71.0/255.0 blue:255.0/255.0 alpha:1] forState:UIControlStateSelected];
            btn.layer.borderWidth = 1;
            btn.layer.borderColor = [UIColor colorWithRed:225.0/255.0 green:225.0/255.0 blue:225.0/255.0 alpha:1].CGColor;
            btn.layer.cornerRadius = 18;
            [btn addTarget:self action:@selector(btnSelected:) forControlEvents:UIControlEventTouchUpInside];
            [self.infoView addSubview:btn];
            btnMaxY = CGRectGetMaxY(btn.frame);
            [self.btnList addObject:btn];
        }
        
        UIImageView *lineImgview = [[UIImageView alloc] initWithFrame:CGRectMake(0, btnMaxY+20, CGRectGetWidth(self.infoView.frame), 0.5)];
        lineImgview.backgroundColor = [UIColor colorWithRed:228.0/255.0 green:228.0/255.0 blue:228.0/255.0 alpha:1];
        [self.infoView addSubview:lineImgview];
        
        UIButton *doneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        doneBtn.frame = CGRectMake((CGRectGetWidth(self.infoView.frame)-btnWidth)/2, CGRectGetMinY(lineImgview.frame) ,  btnWidth, btnHeight);
        doneBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [doneBtn setTitleColor:[UIColor colorWithRed:0.0/255.0 green:71.0/255.0 blue:255.0/255.0 alpha:1] forState:UIControlStateNormal];
        [doneBtn addTarget:self action:@selector(doneBtnSelect) forControlEvents:UIControlEventTouchUpInside];
        [doneBtn setTitle:@"确定" forState:UIControlStateNormal];
        [self.infoView addSubview:doneBtn];
    }
    return self;
}

- (void)setInfoViewMinX:(float)x MinY:(float)y
{
    float deviceHeight = [[UIScreen mainScreen] bounds].size.height;
    float height = deviceHeight - y;
    if (height > CGRectGetHeight(self.infoView.frame))
    {
        self.infoView.frame = CGRectMake(CGRectGetMinX(self.infoView.frame), y , CGRectGetWidth(self.infoView.frame), CGRectGetHeight(self.infoView.frame));
        self.hornImgView.frame = CGRectMake(x-2*CGRectGetMinX(self.infoView.frame), -8+1, 8, 8);
    }
    else
    {
        self.infoView.frame = CGRectMake(CGRectGetMinX(self.infoView.frame), y-CGRectGetHeight(self.infoView.frame) - 30 , CGRectGetWidth(self.infoView.frame), CGRectGetHeight(self.infoView.frame));
        self.hornImgView.frame = CGRectMake(x-2*CGRectGetMinX(self.infoView.frame), CGRectGetHeight(self.infoView.frame)-1, 8, 8);
        self.hornImgView.transform =  CGAffineTransformMakeRotation(3*M_PI_2);
    }
}

- (void)btnSelected:(UIButton *)btn
{
    btn.selected = !btn.isSelected;
    if (btn.selected)
    {
        btn.layer.borderColor = [UIColor colorWithRed:0.0/255.0 green:71.0/255.0 blue:255.0/255.0 alpha:1].CGColor;
    }
    else
    {
        btn.layer.borderColor =  [UIColor colorWithRed:225.0/255.0 green:225.0/255.0 blue:225.0/255.0 alpha:1].CGColor;
    }
}

- (void)doneBtnSelect
{
    if (self.mwMaskDelegate && [self.mwMaskDelegate respondsToSelector:@selector(shieldContentWithIndex:andReasonStr:)])
    {
        __block NSString *str = @"";
        [self.btnList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UIButton *btn = obj;
            if (btn.isSelected)
            {
                str = [str stringByAppendingFormat:@"%@",@(idx)];
            }
        }];
        [self.mwMaskDelegate shieldContentWithIndex:self.index andReasonStr:str];
    }
    [self removeFromSuperview];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self removeFromSuperview];
}

@end
