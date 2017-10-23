//
//  ViewController.m
//  Cafei17-720
//
//  Created by cafei on 2017/7/20.
//  Copyright © 2017年 cafei. All rights reserved.
//

#import "MWContentMainViewController.h"
#import "MWContentTitleBarViewController.h"
#import "MWContentApi.h"
#import "MWContentTableViewController.h"
#import "MWContentCategoriesDomain.h"

#define     MWC_key                         @"I5EE1571"

@interface MWContentMainViewController ()

@property (nonatomic, strong) MWContentTitleBarViewController *titleBarVC;

@end

@implementation MWContentMainViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    __weak typeof (self) weakSelf = self;
    [MWContentApi getCategoriesWithMWKey:MWC_key Success:^(NSArray *categories) {
        
        if (categories == nil || categories.count == 0) return;
        __block NSMutableArray *titleList = [[NSMutableArray alloc] init];
        __block NSMutableArray *vcList = [[NSMutableArray alloc] init];
        [categories enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            MWContentCategoriesDomain *domain = obj;
            MWContentTableViewController *vc = [[MWContentTableViewController alloc] init];
            vc.spm = domain.spm;
            [titleList addObject:domain.name];
            [vcList addObject:vc];
        }];
           [weakSelf loadTitleBarWithTitleList:titleList Controllers:vcList];
        
    } Failure:^(NSString *errorStr) {
        NSLog(@"%@", errorStr);
    }];
  
}

- (void)loadTitleBarWithTitleList:(NSArray *)titleList Controllers:(NSArray *)vcList
{
    self.titleBarVC = [[MWContentTitleBarViewController alloc] init];
    [self addChildViewController:self.titleBarVC];
    self.titleBarVC.view.frame = self.view.bounds;
    self.titleBarVC.titleBar.frame = CGRectMake(0, 20, CGRectGetWidth(self.view.frame), 50);
    [self.view addSubview:self.titleBarVC.view];
    
    MWContentTitleBarConfig *barConfig = [[MWContentTitleBarConfig alloc] init];
    barConfig.btnLimitMargin = 30;
    [self.titleBarVC.titleBar updateBarWithConfig:barConfig];
    
    [self.titleBarVC setItemsWithTitleList:titleList Controllers:vcList];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
