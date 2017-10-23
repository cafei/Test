//
//  MWShieldContentMaskView.h
//  Cafei17-720
//
//  Created by cafei on 2017/8/22.
//  Copyright © 2017年 cafei. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MWContentMaskDelegate <NSObject>

- (void)shieldContentWithIndex:(NSInteger)index andReasonStr:(NSString *)reasonStr;

@end

@interface MWShieldContentMaskView : UIView

@property (nonatomic, weak) id<MWContentMaskDelegate> mwMaskDelegate;
@property (nonatomic, assign) NSInteger index;

- (void)setInfoViewMinX:(float)x MinY:(float)y;

@end
