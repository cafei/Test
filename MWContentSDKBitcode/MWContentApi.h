//
//  MWContentApi.h
//  Cafei17-720
//
//  Created by cafei on 2017/8/14.
//  Copyright © 2017年 cafei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MWContentDomain.h"
#import <UIKit/UIKit.h>

@interface MWContentApi : NSObject

/**
 *  初始化MWContentSDK
 *  @param accountKey secretCode ,魔窗后台注册的accountKey和secretCode
 */
+ (void)registerMWContentWithAccountKey:(nonnull NSString *)accountKey SecretCode:(nonnull NSString *)secretCode;

/**
*  获取内容的导航信息
*  @param mwkey 魔窗位key
*  @param success callback 成功获取到内容的导航信息
*  @param failure callback 获取导航信息失败
*/
+ (void)getCategoriesWithMWKey:(nonnull NSString *)mwkey Success:(void(^ _Nullable)(NSArray *__nullable categories))success Failure:(void(^ _Nullable)(NSString *__nullable errorStr))failure;

/**
 *  根据spm获取内容列表
 *  @param spm 如果没有spm请使用getContentWithMWKey:
 *  @param pageIndex 分页，第几页，从1开始
 *  @param pageSize 分页内容数（最大20）
 *  @param success callback 成功获取到内容列表
 *  @param failure callback 获取内容失败
 */
+ (void)getContentWithSpm:(nonnull NSString *)spm PageIndex:(NSInteger)pageIndex PageSize:(NSInteger)pageSize Success:(void(^ _Nullable)(NSArray *__nullable contentList))success Failure:(void(^ _Nullable)(NSString *__nullable errorStr))failure;

/**
 *  根据魔窗位key获取内容列表
 *  @param mwkey 魔窗位key
 *  @param pageIndex 分页，第几页，从1开始
 *  @param pageSize 分页内容数（最大20）
 *  @param success callback 成功获取到内容列表
 *  @param failure callback 获取内容失败
 */
+ (void)getContentWithMWKey:(nonnull NSString *)mwkey PageIndex:(NSInteger)pageIndex PageSize:(NSInteger)pageSize Success:(void(^ _Nullable)(NSArray *__nullable contentList))success Failure:(void(^ _Nullable)(NSString *__nullable errorStr))failure;

/**
 *  精准屏蔽内容
 *  @param spm 如果没有spm请使用shielContentWithMWKey:
 *  @param contentId 内容唯一ID
 *  屏蔽内容的原因分别是@"推荐单一",@"重复推荐",@"内容低俗",@"标题夸张",@"广告软文",@"页面出错"
 *  @param reasonStr  如果选择了@"推荐单一"@"标题夸张"两个原因，那么reasonStr的值为@"03"
 */
+ (void)shielContentWithSpm:(nonnull NSString *)spm ContentId:(nonnull NSString *)contentId ReasonStr:(nonnull NSString *)reasonStr CompletionHandler:(void(^ _Nullable)(BOOL success, NSString *__nullable errorStr))completionHandler;

/**
 *  精准屏蔽内容
 *  @param mwkey 魔窗位key
 *  @param contentId 内容唯一ID
 *  屏蔽内容的原因分别是@"推荐单一",@"重复推荐",@"内容低俗",@"标题夸张",@"广告软文",@"页面出错"
 *  @param reasonStr  如果选择了@"推荐单一"@"标题夸张"两个原因，那么reasonStr的值为@"03"
 */
+ (void)shielContentWithMWKey:(nonnull NSString *)mwkey ContentId:(nonnull NSString *)contentId ReasonStr:(nonnull NSString *)reasonStr CompletionHandler:(void(^ _Nullable)(BOOL success, NSString *__nullable errorStr))completionHandler;

+ (void)contentClickTracking:(nonnull NSArray *)list;

+ (void)contentExposureTracking:(nonnull NSArray *)list;

/**
 * 注册一个内容回流的mlink，当接收到内容回流的时候，会调用此handler
 * 需要在 AppDelegate 的 didFinishLaunchingWithOptions 中调用
 * @param handler mlink的回调,params为动态参数
 */
+ (void)registerMLinkHandlerForContentBackflow:(void(^_Nullable)(NSURL * __nonnull url, NSDictionary * __nullable params))handler;

/**
 * 点击内容的tableview的时候，进入具体的内容页
 */
+ (void)showContent:(nonnull MWContentDomain *)content NavgationController:(nonnull UINavigationController *)navVC HidesBottomBarWhenPushed:(BOOL)hidesBottomBarWhenPushed;

/**
 * 当从微信或者第三方唤起app并且接收到内容回流请求的时候，跳转到具体的内容页
 */
+ (void)showContentBackflowWithNavgationController:(nonnull UINavigationController *)navVC HidesBottomBarWhenPushed:(BOOL)hidesBottomBarWhenPushed;

@end
