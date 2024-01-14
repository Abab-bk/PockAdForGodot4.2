package com.acidwall.pocketad;

import android.app.Activity;
import android.util.Log;
import android.view.View;
import android.widget.FrameLayout;

import com.zh.pocket.PocketSdk;
import com.zh.pocket.ads.reward_video.RewardVideoAD;
import com.zh.pocket.ads.reward_video.RewardVideoADListener;
import com.zh.pocket.error.ADError;

import org.godotengine.godot.Godot;
import org.godotengine.godot.plugin.GodotPlugin;
import org.godotengine.godot.plugin.SignalInfo;
import org.godotengine.godot.plugin.UsedByGodot;

import java.util.HashSet;
import java.util.Set;

public class ADMaster extends GodotPlugin {
    //定义信号名字 信号链接是在godot链接的
    public SignalInfo adReady = new SignalInfo("adReady");
    //激励广告信号
    public SignalInfo RewardGet    = new SignalInfo("RewardGet");
    public SignalInfo RewardClosed = new SignalInfo("RewardClosed");
    public SignalInfo RewardFailed = new SignalInfo("RewardFailed");

    public SignalInfo InitAD = new SignalInfo("InitAD");

    public FrameLayout layout;
    public Activity activity;
    public String Tag;

    public ADMaster(Godot godot) {
        super(godot);
        activity = getActivity();
        PocketSdk.initSDK(getActivity(), "taptap", "12519");
        Tag = ADMaster.class.toString();
    }

    @Override
    public String getPluginName() {
        return "RealPocket";
    }

    //向引擎注册信号
    @Override
    public Set<SignalInfo> getPluginSignals() {
        HashSet<SignalInfo> signals = new HashSet<SignalInfo>();
        signals.add(adReady);
        //激励
        signals.add(RewardGet);
        signals.add(RewardClosed);
        signals.add(RewardFailed);
        signals.add(InitAD);
        return signals;
    }

    @Override
    public View onMainCreate(Activity activity) {
        this.layout = new FrameLayout(activity);
        return this.layout;
    }

    // 展示激励视频
    @UsedByGodot
    public void ShowRewardVideoAd(String id) {
        emitSignal(InitAD.getName());
        Log.e("传入ID: ", id);
        RewardVideoAD VideoAd = new RewardVideoAD(getActivity(), id);
        VideoAd.setRewardVideoADListener(new RewardVideoADListener() {
            @Override
            public void onFailed(ADError adError) {
                Log.e("RewardVideo","激励视频加载失败");
                Log.e("RewardVideo",adError.toString());
                emitSignal(RewardFailed.getName());
            }

            @Override
            public void onSuccess() {
                Log.e("RewardVideo","激励视频加载成功");
            }

            @Override
            public void onVideoCached() {
                Log.e("RewardVideo","奖励视频被缓存");
                VideoAd.showAD();
            }

            @Override
            public void onADShow() {
                Log.e("RewardVideo","奖励视频被展示");
            }

            @Override
            public void onADExposure() {
                Log.e("RewardVideo","奖励视频被曝光");
            }

            @Override
            public void onReward() {
                emitSignal(RewardGet.getName());
            }

            @Override
            public void onADClicked() {
                Log.e("RewardVideo","广告被点击");
            }

            @Override
            public void onADClosed() {
                Log.e("RewardVideo","奖励视频被关闭");
                emitSignal(RewardClosed.getName());
            }

            @Override
            public void onVideoComplete() {
                Log.e("RewardVideo","奖励视频播放完毕");
            }

            @Override
            public void onSkippedVideo() {
                Log.e("RewardVideo","广告被跳过");
            }

            @Override
            public void onADLoaded() {
                Log.e("RewardVideo","激励视频加载了");
            }
        });
        VideoAd.loadAD();
    }
}