package com.haxifang.ad;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContext;
import com.facebook.react.common.MapBuilder;
import com.facebook.react.uimanager.ThemedReactContext;
import com.facebook.react.uimanager.ViewGroupManager;
import com.facebook.react.uimanager.annotations.ReactProp;
import com.haxifang.ad.views.BannerAdView;

import java.util.Map;

public class BannerAdViewManager extends ViewGroupManager<BannerAdView> {

    public static final String TAG = "BannerAd";
    private ReactContext mContext;

    public BannerAdViewManager(ReactApplicationContext context) {
        mContext = context;
    }

    @NonNull
    @Override
    public String getName() {
        return TAG;
    }

    @NonNull
    @Override
    protected BannerAdView createViewInstance(@NonNull ThemedReactContext reactContext) {
        return new BannerAdView(reactContext);
    }

    @Override
    public boolean needsCustomLayoutForChildren() {
        return true;
    }

    // 设置什么广告（头条，腾讯，百度），暂时不用
//    @ReactProp(name = "provider")
//    public void setProvider(BannerAdView view, @Nullable String provider) {
//        view.setProvider(provider);
//    }

    // 设置广告是否使用缓存，现在先不用
//    @ReactProp(name = "useCache")
//    public void setUseCache(BannerAdView view, @Nullable Boolean useCache) {
//        view.setUseCache(useCache);
//    }


    @ReactProp(name = "codeid")
    public void setCodeId(BannerAdView view, @Nullable String codeid) {
        view.setCodeId(codeid);
    }

    // 设置大小，暂时不用
//    @ReactProp(name = "size")
//    public void setSize(BannerAdView view, @Nullable String size) {
//        view.setSize(size);
//    }

    @ReactProp(name = "adWidth")
    public void setAdWidth(BannerAdView view, @Nullable int adWidth) {
        view.setWidth(adWidth);
    }

    @Override
    public Map getExportedCustomBubblingEventTypeConstants() {
        return MapBuilder.builder()
                .put("onAdClick",
					MapBuilder.of(
						"phasedRegistrationNames",
						MapBuilder.of("bubbled", "onAdClick")))
                .put("onAdError",
					MapBuilder.of(
						"phasedRegistrationNames",
						MapBuilder.of("bubbled", "onAdError")))
                .put("onAdClose",
					MapBuilder.of(
						"phasedRegistrationNames",
						MapBuilder.of("bubbled", "onAdClose")))
                .put("onAdLayout",
					MapBuilder.of(
						"phasedRegistrationNames",
						MapBuilder.of("bubbled", "onAdLayout")))
                .build();
    }


}
