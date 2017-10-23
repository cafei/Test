//
//  MWContentTitleBarViewController.m
//  Cafei17-720
//
//  Created by cafei on 2017/7/21.
//  Copyright © 2017年 cafei. All rights reserved.
//

#import "MWContentTitleBarViewController.h"

@interface MWContentTitleBarViewController ()<UIScrollViewDelegate,MWContentTitleBarDelegate>

@property (nonatomic, strong) UIScrollView *contentScrollView;

@end

@implementation MWContentTitleBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    if (self.titleBar.frame.size.height < 1)
    {
        self.titleBar.frame = CGRectMake(0, 20, CGRectGetWidth(self.view.frame), 50);
    }
    self.contentScrollView.frame = CGRectMake(0, CGRectGetMaxY(self.titleBar.frame), CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-CGRectGetMaxY(self.titleBar.frame));
}

- (MWContentTitleBar *)titleBar
{
    if (_titleBar == nil)
    {
        _titleBar = [[MWContentTitleBar alloc] init];
        _titleBar.delegate = self;
        [self.view addSubview:_titleBar];
    }
    return _titleBar;
}

- (UIScrollView *)contentScrollView
{
    if (_contentScrollView == nil)
    {
        UIScrollView *contentView = [[UIScrollView alloc] init];
        contentView.delegate = self;
        contentView.pagingEnabled = YES;
        contentView.showsVerticalScrollIndicator = NO;
        contentView.showsHorizontalScrollIndicator = NO;
        contentView.scrollsToTop = NO;
        contentView.tag = 7373;
        [self.view addSubview:contentView];
        _contentScrollView = contentView;
    }
    return _contentScrollView;
}

- (void)setItemsWithTitleList:(NSArray *)titleList Controllers:(NSArray *)controllers
{
    if (titleList == nil || controllers == nil || titleList.count == 0 || titleList.count != controllers.count)
    {
        return;
    }
    self.titleBar.titleModels = titleList;
    [self.childViewControllers makeObjectsPerformSelector:@selector(removeFromParentViewController)];
    [controllers enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self addChildViewController:obj];
    }];
    self.titleBar.selectedIndex = 0;
    self.contentScrollView.contentSize = CGSizeMake(self.childViewControllers.count*CGRectGetWidth(self.view.frame),0);
}

#pragma mark UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger nextIndex = self.titleBar.selectedIndex;
    if (scrollView.contentOffset.x/scrollView.frame.size.width > self.titleBar.selectedIndex)
    {
        nextIndex ++;
    }
    else
    {
        nextIndex --;
    }
    if (nextIndex < 0 || nextIndex > self.childViewControllers.count-1)
    {
        return;
    }
    UIViewController  *vc = self.childViewControllers[nextIndex];
    vc.view.frame = CGRectMake(nextIndex*CGRectGetWidth(self.contentScrollView.frame), 0, CGRectGetWidth(self.contentScrollView.frame), CGRectGetHeight(self.contentScrollView.frame));
    [self.contentScrollView addSubview:vc.view];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    self.titleBar.selectedIndex = scrollView.contentOffset.x/scrollView.frame.size.width;
}

#pragma mark MWContentTitleBarDelegate
- (void)MWContentTitleBarDidSelectedIndex:(NSInteger)index
{
    [self showCurrentChildViewWithIndex:index];
}

- (void)showCurrentChildViewWithIndex:(NSInteger)index
{
    if (self.childViewControllers == nil || self.childViewControllers.count == 0 || index< 0 || index > self.childViewControllers.count -1)
    {
        return;
    }
    UIViewController  *vc = self.childViewControllers[index];
    vc.view.frame = CGRectMake(index*CGRectGetWidth(self.contentScrollView.frame), 0, CGRectGetWidth(self.contentScrollView.frame), CGRectGetHeight(self.contentScrollView.frame));
    [self.contentScrollView addSubview:vc.view];
    [self.contentScrollView setContentOffset:CGPointMake(index*CGRectGetWidth(self.contentScrollView.frame), 0) animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    _titleBar.delegate = nil;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
