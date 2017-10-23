//
//  MWContentTitleBarViewController.h
//  Cafei17-720
//
//  Created by cafei on 2017/7/21.
//  Copyright © 2017年 cafei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MWContentTitleBar.h"

@interface MWContentTitleBarViewController : UIViewController

@property (nonatomic, strong) MWContentTitleBar *titleBar;

- (void)setItemsWithTitleList:(NSArray *)titleList Controllers:(NSArray *)controllers;

@end
