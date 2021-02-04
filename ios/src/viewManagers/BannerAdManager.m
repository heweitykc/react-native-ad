//
//  FeedAdManager.m
//  datizhuanqian
//
//  Created by ivan zhang on 2019/9/19.
//  Copyright © 2019 Facebook. All rights reserved.
//

#import <React/RCTViewManager.h>
#import "BannerAd.h"

@interface BannerAdManager : RCTViewManager

@end


@implementation BannerAdManager

RCT_EXPORT_MODULE(BannerAd)

RCT_EXPORT_VIEW_PROPERTY(onAdLayout, RCTBubblingEventBlock)
RCT_EXPORT_VIEW_PROPERTY(onAdError, RCTBubblingEventBlock)
RCT_EXPORT_VIEW_PROPERTY(onAdClick, RCTBubblingEventBlock)
RCT_EXPORT_VIEW_PROPERTY(onAdClose, RCTBubblingEventBlock)

- (BannerAd *)view
{
  return [[BannerAd alloc] init];
}

RCT_CUSTOM_VIEW_PROPERTY(codeid, NSString, BannerAd)
{
  if (json) {
      NSLog(@"设置codeId:%@",json);

    [view  setCodeId:json];
  }
}

RCT_CUSTOM_VIEW_PROPERTY(width, NSString, BannerAd)
{
    NSLog(@"设置width:%@",json);
  if (json) {
    [view  setAdWidth:json];
  }
}

@end
