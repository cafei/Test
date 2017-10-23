//
//  MWContentDomain.h
//  Cafei17-720
//
//  Created by cafei on 2017/8/14.
//  Copyright © 2017年 cafei. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    MWC_NORMAL_MAIN_IMG ,       //大图
    MWC_NORMAL_ICON_IMG ,       //小图
    MWC_NORMAL_MORE_IMG ,     //多图
    MWC_OTHER
}MWCMaterialType;

@interface MWContentImageDomain : NSObject

@property (nonatomic, strong) NSString *url;
@property (nonatomic, assign) int height;
@property (nonatomic, assign) int width;

@end

@interface MWContentPreviewImgDomain : NSObject

@property (nonatomic, strong) MWContentImageDomain *largeImage;
@property (nonatomic, strong) NSArray *imageList;
@property (nonatomic, strong) MWContentImageDomain *smallImage;

@end

@interface MWContentTrackingDomain : NSObject

@property (nonatomic, strong) NSArray *clickLinks;
@property (nonatomic, strong) NSArray *impressionLinks;

@end

@interface MWContentMarkDomain : NSObject

@property (nonatomic, strong) NSString *mark;
@property (nonatomic, strong) NSString *color;

@end

@interface MWContentLikeIpDoamin : NSObject

@property (nonatomic, assign) long likeNum;
@property (nonatomic, assign) long unlikeNum;
@property (nonatomic, assign) long readNum;

@end

@interface MWContentDomain : NSObject

@property (nonatomic, strong) NSString *contentId;      //内容唯一ID
@property (nonatomic, strong) NSString *title;          //内容标题
@property (nonatomic, strong) NSString *productName;        //内容来源
@property (nonatomic, strong) MWContentPreviewImgDomain *previewImage;
@property (nonatomic, strong) NSString *tags;       //内容相关标签
@property (nonatomic, strong) NSString *summary;        //摘要信息
@property (nonatomic, strong) NSString *contentUrl;         //内容URL
@property (nonatomic, assign) long publishTime;     //内容发布时间
@property (nonatomic, strong) NSString *shortUrl;   //短链接
@property (nonatomic, strong) NSString *rawContent;     //原始内容信息
@property (nonatomic, strong) NSArray *contentImage;        //内容图片
@property (nonatomic, strong) MWContentMarkDomain *bottomLeftMark;       //内容tips
@property (nonatomic, strong) MWContentLikeIpDoamin *likeIp;
@property (nonatomic, strong) NSString *mediaType;      //video, audio, text, complex
@property (nonatomic, strong) MWContentTrackingDomain *contentTracking;
@property (nonatomic, assign) BOOL ad;          //是否为广告
@property (nonatomic, strong) NSString *appDownloadUrl;     //当ad=true时，app的下载地址
@property (nonatomic, assign) MWCMaterialType materialType;

@end
