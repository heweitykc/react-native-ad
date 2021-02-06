//
//  SplashAd.m
//
//  Created by ivan zhang on 2019/9/19.
//  Copyright © 2019 Facebook. All rights reserved.
//

#import "SplashAd.h"

@interface SplashAd () <BUSplashAdDelegate>
@property(nonatomic, strong) UIView *adv;
@property(nonatomic, strong) BUSplashAdView *splashView;

@end

@implementation SplashAd

RCT_EXPORT_MODULE();

+ (BOOL)requiresMainQueueSetup {
    return YES;
}

- (dispatch_queue_t)methodQueue
{
    return dispatch_get_main_queue();
}

- (NSArray<NSString *> *)supportedEvents {
    return @[
        @"SplashAd-onAdClose",
        @"SplashAd-onAdSkip",
        @"SplashAd-onAdError",
        @"SplashAd-onAdClick",
        @"SplashAd-onAdShow"
    ];
}

RCT_EXPORT_METHOD(loadSplashAd:(NSDictionary *)options resolve:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject)
{
    
    NSString  *codeid = options[@"codeid"];
    if(codeid == nil) {
        return;
    }
    
    NSString  *appid = options[@"appid"];
    if(appid != nil) {
        [AdBoss init:appid];
    }
    
    NSLog(@"Bytedance splash 开屏ios 代码位id %@", codeid);
    
    //穿山甲开屏广告
    CGFloat customvw = [UIScreen mainScreen].bounds.size.width;
    CGFloat customvh = 100;
    CGRect frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-customvh);
    BUSplashAdView *splashView = [[BUSplashAdView alloc] initWithSlotID:codeid frame:frame]; //答妹ios测试 开屏广告位
    _splashView = splashView;
    
    splashView.tolerateTimeout = 10;
    splashView.delegate = self; //[AdBoss getApp];
    
    [splashView loadAdData];

    UIView *bgv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    _adv = bgv;
    bgv.backgroundColor = [UIColor whiteColor];
    [bgv addSubview:splashView];
    
    UIView *logov =  [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height, [UIScreen mainScreen].bounds.size.width, customvh)];
    UIImageView *logoimg = [[UIImageView alloc] initWithFrame:CGRectMake(customvw/2-30-50, (customvh-50)/2, 50, 50)];
    logoimg.image = [UIImage imageNamed:@"logo_corner"];
    [logov addSubview:logoimg];
    UIImageView *titleimg = [[UIImageView alloc] initWithFrame:CGRectMake(customvw/2-10, (customvh-25)/2, 100, 25)];
    titleimg.image = [UIImage imageNamed:@"titleimg"];
    [logov addSubview:titleimg];
    [bgv addSubview:logov];
    
    splashView.rootViewController = [AdBoss getRootVC];
    
    resolve(@"结果：Splash Ad 成功");
}

//穿山甲开屏广告 回调
- (void)splashAdDidLoad:(BUSplashAdView *)splashAd {
    NSLog(@"SplashAd-onAdShow ...");
    [[AdBoss getRootVC].view addSubview:_adv];
    [self sendEventWithName:@"SplashAd-onAdShow" body:@""];
}

- (void)splashAdWillVisible:(BUSplashAdView *)splashAd{
    NSLog(@"SplashAd-onAdWillVisible ...");
}

- (void)splashAdDidClick:(BUSplashAdView *)splashAd {
    NSLog(@"SplashAd-onAdClick ...");
    [_adv removeFromSuperview];
    _splashView = nil;
    [self sendEventWithName:@"SplashAd-onAdClick" body:@"..."];
}

- (void)splashAdDidClickSkip:(BUSplashAdView *)splashAd {
    NSLog(@"SplashAd-onAdSkip ...");
    [_adv removeFromSuperview];
    _splashView = nil;
    [self sendEventWithName:@"SplashAd-onAdSkip" body:@""];
}

- (void)splashAdDidClose:(BUSplashAdView *)splashAd {
    NSLog(@"SplashAd-onAdClose ...");
    [_adv removeFromSuperview];
    _splashView = nil;
    [self sendEventWithName:@"SplashAd-onAdClose" body:@""];
}

- (void)splashAd:(BUSplashAdView *)splashAd didFailWithError:(NSError *)error {
    NSLog(@"SplashAd-onAdError ...");
    [_adv removeFromSuperview];
    _splashView = nil;
    [self sendEventWithName:@"SplashAd-onAdError" body:@""];
}

@end


