//
//  MWContentTableViewController.m
//  Cafei17-720
//
//  Created by cafei on 2017/7/26.
//  Copyright © 2017年 cafei. All rights reserved.
//

#import "MWContentTableViewController.h"
#import "MJRefresh.h"
#import "MWContentApi.h"
#import "MWContentViewCell.h"
#import "MWShieldContentMaskView.h"
#import "UIImageView+WebCache.h"

@interface MWContentTableViewController ()<MWContentViewCellDelegate,MWContentMaskDelegate>

@property (nonatomic, strong) NSMutableArray *contentList;
@property (nonatomic, assign) NSInteger currentPage;

@end

@implementation MWContentTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*
     //系统自带刷新
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"正在刷新"];
    refreshControl.tintColor = [UIColor blackColor];
    [refreshControl addTarget:self action:@selector(pullRefresh) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refreshControl;
     */
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(pullRefresh)];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
    self.tableView.mj_footer.hidden  = YES;
    [self.tableView.mj_header beginRefreshing];
}

- (void)pullRefresh
{
    self.currentPage = 1;
    __weak typeof(self) weakSelf = self;
    __weak UITableView *tbview = self.tableView;
    if (self.spm != nil)
    {
        [MWContentApi getContentWithSpm:self.spm PageIndex:self.currentPage PageSize:20 Success:^(NSArray *contentList) {
            
            weakSelf.contentList = [[NSMutableArray alloc] initWithArray:contentList];
            [self.tableView reloadData];
            [tbview.mj_header endRefreshing];
            if (contentList == nil || contentList.count == 0)
            {
                tbview.mj_footer.hidden = YES;
            }
            else
            {
                tbview.mj_footer.hidden = NO;
            }
            
        } Failure:^(NSString *errorStr) {
            [tbview.mj_header endRefreshing];
        }];
    }
    else
    {
        [MWContentApi getContentWithMWKey:self.mwkey PageIndex:self.currentPage PageSize:20 Success:^(NSArray *contentList) {
            
            weakSelf.contentList = [[NSMutableArray alloc] initWithArray:contentList];
            [self.tableView reloadData];
            [tbview.mj_header endRefreshing];
            tbview.mj_footer.hidden = NO;
            
        } Failure:^(NSString *errorStr) {
            [tbview.mj_header endRefreshing];
        }];
    }
    
}

- (void)loadMore
{
    self.currentPage ++;
    __weak typeof(self) weakSelf = self;
    __weak UITableView *tbview = self.tableView;
    if (self.spm != nil)
    {
        [MWContentApi getContentWithSpm:self.spm PageIndex:self.currentPage PageSize:20 Success:^(NSArray *contentList) {
            if (contentList == nil || contentList.count == 0)
            {
                tbview.mj_footer.hidden = NO;
            }
            else
            {
                [weakSelf.contentList addObjectsFromArray:contentList];
                [self.tableView reloadData];
            }
            [tbview.mj_footer endRefreshing];
            
        } Failure:^(NSString *errorStr) {
            [tbview.mj_footer endRefreshing];
        }];
    }
    else
    {
        [MWContentApi getContentWithMWKey:self.mwkey PageIndex:self.currentPage PageSize:20 Success:^(NSArray *contentList) {
            if (contentList == nil || contentList.count == 0)
            {
                tbview.mj_footer.hidden = NO;
            }
            else
            {
                [weakSelf.contentList addObjectsFromArray:contentList];
                [self.tableView reloadData];
            }
            [tbview.mj_footer endRefreshing];
            
        } Failure:^(NSString *errorStr) {
            [tbview.mj_footer endRefreshing];
        }];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.contentList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MWContentDomain *content = self.contentList[indexPath.row];
    NSString *identifier = @"MWCCell";
    switch (content.materialType) {
        case MWC_NORMAL_ICON_IMG:
            identifier = @"MWCIconCell";
            break;
        case MWC_NORMAL_MAIN_IMG:
            identifier = @"MWCMainCell";
            break;
        case MWC_NORMAL_MORE_IMG:
            identifier = @"MWCMoreCell";
            break;
        default:
            break;
    }
    MWContentViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil)
    {
        cell = [[MWContentViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.mwdelegate = self;
    }
    cell.tag = indexPath.row;
    [cell loadviewWithObject:content];
    switch (content.materialType) {
        case MWC_NORMAL_ICON_IMG:
        {
             [cell.iconImageView sd_setImageWithURL:[NSURL URLWithString:content.previewImage.smallImage.url]];
            break;
        }
        case MWC_NORMAL_MAIN_IMG:
        {
            [cell.mainImageView sd_setImageWithURL:[NSURL URLWithString:content.previewImage.largeImage.url]];
            break;
        }
        case MWC_NORMAL_MORE_IMG:
        {
            [cell.imageViewlist enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                UIImageView *imView = obj;
                MWContentImageDomain *imgDomain = content.previewImage.imageList[idx];
                [imView sd_setImageWithURL:[NSURL URLWithString:imgDomain.url]];
            }];
            break;
        }
        default:
            break;
    }
    [MWContentApi contentExposureTracking:content.contentTracking.impressionLinks];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
     [cell setFrame:CGRectMake(0, 0, tableView.frame.size.width, MAXFLOAT)];
    return cell.frame.size.height;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MWContentDomain *content = self.contentList[indexPath.row];
    [MWContentApi showContent:content NavgationController:self.navigationController HidesBottomBarWhenPushed:YES];
}

#pragma mark MWContentViewCellDelegate
- (void)deleteTheContent:(NSInteger)index
{
    float deviceHeight = [[UIScreen mainScreen] bounds].size.height;
    float tabBatHeight = 0;
    CGRect cellFrame =[self.tableView rectForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
    CGRect rectInSuperView = [self.tableView convertRect:cellFrame toView:[self.tableView superview]];
    float y = deviceHeight-CGRectGetHeight(self.view.frame)-tabBatHeight + CGRectGetMinY(rectInSuperView)+CGRectGetHeight(cellFrame);
    
    MWContentViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
    
    UIViewController *rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    MWShieldContentMaskView *maskview = [[MWShieldContentMaskView alloc] initWithFrame:rootVC.view.bounds];
    [maskview setInfoViewMinX:CGRectGetMinX(cell.optionImgview.frame) MinY:y];
    maskview.index = index;
    maskview.mwMaskDelegate = self;
    [rootVC.view addSubview:maskview];
}

#pragma mark MWContentMaskDelegate
- (void)shieldContentWithIndex:(NSInteger)index andReasonStr:(NSString *)reasonStr
{
    MWContentDomain *contentDomin = self.contentList[index];
    __weak UITableView *tbview = self.tableView;
    if (self.spm != nil)
    {
        [MWContentApi shielContentWithSpm:self.spm ContentId:contentDomin.contentId ReasonStr:reasonStr CompletionHandler:^(BOOL success, NSString *errorStr) {
            if (success)
            {
                [self.contentList removeObjectAtIndex:index];
                [tbview deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:index inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
                [self.tableView reloadData];
            }
        }];
    }
    else
    {
        [MWContentApi shielContentWithMWKey:self.mwkey ContentId:contentDomin.contentId ReasonStr:reasonStr CompletionHandler:^(BOOL success, NSString *errorStr) {
            if (success)
            {
                [self.contentList removeObjectAtIndex:index];
                [tbview deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:index inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
                [self.tableView reloadData];
            }
        }];
    }
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
