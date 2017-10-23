//
//  MWContentViewCell.h
//  Cafei17-720
//
//  Created by cafei on 2017/8/15.
//  Copyright © 2017年 cafei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MWContentDomain.h"

@protocol MWContentViewCellDelegate <NSObject>

- (void)deleteTheContent:(NSInteger)index;

@end

@interface MWContentViewCell : UITableViewCell

@property (nonatomic, weak) id<MWContentViewCellDelegate> mwdelegate;

/**
 * 小图
 */
@property (strong, nonatomic)  UIImageView *iconImageView;
/**
 * 大图
 */
@property (strong, nonatomic)  UIImageView *mainImageView;
/**
 * 多图 image view list
 */
@property (strong, nonatomic) NSMutableArray *imageViewlist;
/**
 * 内容标示 view
 */
@property (strong, nonatomic)  UILabel *markLabel;
/**
 * 人数 view
 */
@property (strong, nonatomic)  UILabel *numberLabel;

/**
 * 标题 view
 */
@property (strong, nonatomic)  UILabel *titleLabel;
/**
 * 内容来源 view
 */
@property (strong, nonatomic)  UILabel *productLabel;

@property (nonatomic, strong) UIImageView *optionImgview;


- (void)loadviewWithObject:(MWContentDomain *)object;

@end
