//
//  MWContentTitleBarConfig.h
//  Cafei17-720
//
//  Created by cafei on 2017/7/20.
//  Copyright © 2017年 cafei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MWContentTitleBarConfig : NSObject

@property (nonatomic, strong) UIColor *titleBarBGColor;   //标题栏的背景色
@property (nonatomic, assign) float btnLimitMargin;       //每个标签之间的最小间距
@property (nonatomic, strong) UIColor *btnNormalColor;  //每个标签的正常字体颜色
@property (nonatomic, strong) UIColor *btnSelectedColor;    //每个标签的选中时的字体颜色
@property (nonatomic, strong) UIFont *btnNormalFont;    //每个标签的正常字体
@property (nonatomic, strong) UIFont *btnSelectedFont;  //每个标签的选中时的字体

@end
