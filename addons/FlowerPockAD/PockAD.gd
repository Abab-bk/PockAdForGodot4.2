extends Node

const APP_ID:String = "xxx"

signal get_reward
signal reward_skip
signal rewrad_closed
signal reward_failed

var ad

var _plugin_name = "RealPocket"
var _android_plugin

func _ready():
    if Engine.has_singleton(_plugin_name):
        _android_plugin = Engine.get_singleton(_plugin_name)
        _android_plugin.initAd(APP_ID)
        _android_plugin.RewardGet.connect(func():
            get_reward.emit())
        _android_plugin.RewardSkip.connect(func():
            reward_skip.emit())
        _android_plugin.RewardFailed.connect(func():
            reward_failed.emit())
        _android_plugin.RewardClosed.connect(func():
            rewrad_closed.emit())
    else:
        print("Couldn't find plugin " + _plugin_name)


func show_reward_video_ad(_ad_id:String = "xxx") -> void:
    if Master.today_watch_ad_count >= Const.MAX_AD_COUNT:
        EventBus.show_popup.emit("达到上限", "今日观看广告次数达到上限")
        return
    _android_plugin.ShowRewardVideoAd(_ad_id)
