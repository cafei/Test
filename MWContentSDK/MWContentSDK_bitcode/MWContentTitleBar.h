//
//  MWContentTitleBar.h
//  Cafei17-720
//
//  Created by cafei on 2017/7/20.
//  Copyright © 2017年 cafei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MWContentTitleBarConfig.h"

@protocol MWContentTitleBarDelegate <NSObject>

- (void)MWContentTitleBarDidSelectedIndex:(NSInteger)index;

@end

@interface MWContentTitleBar : UIView

@property (nonatomic, strong) NSArray *titleModels;
@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, weak) id<MWContentTitleBarDelegate> delegate;

- (void)updateBarWithConfig:(MWContentTitleBarConfig *)config;

@end
