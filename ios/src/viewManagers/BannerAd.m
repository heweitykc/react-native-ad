//
//  FeedAd.m
//  datizhuanqian
//
//  Created by ivan zhang on 2019/9/19.
//  Copyright © 2019 Facebook. All rights reserved.
//

#import "BannerAd.h"
#include "AdBoss.h"
#import <BUAdSDK/BUNativeExpressAdManager.h>
#import <BUAdSDK/BUNativeExpressAdView.h>

#import <BUAdSDK/BUAdSDK.h>

@interface BannerAd ()<BUNativeExpressBannerViewDelegate>

@property (strong, nonatomic) BUNativeExpressBannerView *bannerView;

@property(nonatomic, strong) NSString *_codeid;
@property(nonatomic) NSInteger _adwidth ;

@property(nonatomic) BOOL _didLoad ;
@end

@implementation BannerAd


- (void)setCodeId:(NSString *)codeid {
    self._codeid = codeid;
    
    [self loadBannerAd];
}

- (void)setAdWidth:(NSString *)width {
    self._adwidth = [width integerValue];
    
    [self loadBannerAd];
}

/**
 加载Feed广告
 */
- (void)loadBannerAd{
    if(!self._codeid || self._codeid.length < 1 || !self._adwidth || self._adwidth < 1) return;
    
    if(self._didLoad) {
        NSLog(@"已经开始加载ad...");
        return;
    }

    NSLog(@"开始 加载BannerFeed广告 codeid: %@", self._codeid);
    
    self._didLoad = YES;
    
    // important: 升级的用户请注意，初始化方法去掉了imgSize参数
    self.bannerView = [[BUNativeExpressBannerView alloc] initWithSlotID:self._codeid rootViewController:(UIViewController * )[UIApplication sharedApplication].delegate.window.rootViewController adSize:CGSizeMake(self._adwidth, self._adwidth*75/300)];
    self.bannerView.frame = CGRectMake(0,0,  self._adwidth, self._adwidth*75/300);
    self.bannerView.delegate = self;
    [self.bannerView loadAdData];
}

#pragma mark - BUNativeExpressAdViewDelegate
/**
 This method is called when bannerAdView ad slot loaded successfully.
 @param bannerAdView : view for bannerAdView
 */
- (void)nativeExpressBannerAdViewDidLoad:(BUNativeExpressBannerView *)bannerAdView{
    
}

/**
 This method is called when bannerAdView ad slot failed to load.
 @param error : the reason of error
 */
- (void)nativeExpressBannerAdView:(BUNativeExpressBannerView *)bannerAdView didLoadFailWithError:(NSError *_Nullable)error{
    
}

/**
 This method is called when rendering a nativeExpressAdView successed.
 */
- (void)nativeExpressBannerAdViewRenderSuccess:(BUNativeExpressBannerView *)bannerAdView{
    [self addSubview:bannerAdView];
    
    self.onAdLayout(@{
        @"width":@(bannerAdView.bounds.size.width),
        @"height":@(bannerAdView.bounds.size.height)
    });
}

/**
 This method is called when a nativeExpressAdView failed to render.
 @param error : the reason of error
 */
- (void)nativeExpressBannerAdViewRenderFail:(BUNativeExpressBannerView *)bannerAdView error:(NSError * __nullable)error{
    
}

/**
 This method is called when bannerAdView ad slot showed new ad.
 */
- (void)nativeExpressBannerAdViewWillBecomVisible:(BUNativeExpressBannerView *)bannerAdView{
    
}

/**
 This method is called when bannerAdView is clicked.
 */
- (void)nativeExpressBannerAdViewDidClick:(BUNativeExpressBannerView *)bannerAdView{
    NSLog(@"点击了");
}

/**
 This method is called when the user clicked dislike button and chose dislike reasons.
 @param filterwords : the array of reasons for dislike.
 */
- (void)nativeExpressBannerAdView:(BUNativeExpressBannerView *)bannerAdView dislikeWithReason:(NSArray<BUDislikeWords *> *_Nullable)filterwords{
    [UIView animateWithDuration:0.25 animations:^{
        bannerAdView.alpha = 0;
    } completion:^(BOOL finished) {
        [bannerAdView removeFromSuperview];
        self.bannerView = nil;
        
        self.onAdLayout(@{
            @"width":@(0),
            @"height":@(0)
        });
    }];
}

/**
 This method is called when another controller has been closed.
 @param interactionType : open appstore in app or open the webpage or view video ad details page.
 */
- (void)nativeExpressBannerAdViewDidCloseOtherController:(BUNativeExpressBannerView *)bannerAdView interactionType:(BUInteractionType)interactionType{
    
}


@end
