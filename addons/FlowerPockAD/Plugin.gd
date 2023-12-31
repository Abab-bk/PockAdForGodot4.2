@tool
extends EditorPlugin

var export_plugin : AndroidExportPlugin

func _enter_tree():
    export_plugin = AndroidExportPlugin.new()
    add_export_plugin(export_plugin)
    add_autoload_singleton("PockAD", "PockAD.gd")


func _exit_tree():
    remove_export_plugin(export_plugin)
    export_plugin = null
    remove_autoload_singleton("v")


class AndroidExportPlugin extends EditorExportPlugin:
    var _plugin_name = "PockAD"

    func _supports_platform(platform):
        if platform is EditorExportPlatformAndroid:
            return true
        return false

    func _get_android_libraries(platform, debug):
        if debug:
            return PackedStringArray([
            "FlowerPockAD/bin/debug/FlowerAD-debug.aar",
            "FlowerPockAD/bin/libs/csj_ad_sdk_230215.aar",
            "FlowerPockAD/bin/libs/gdt_ad_sdk_230210.aar",
            "FlowerPockAD/bin/libs/ks_ad_sdk_230116.aar",
            "FlowerPockAD/bin/libs/pocket_ad_sdk_3.2.8.aar",
            ])
        else:
            return PackedStringArray([
            "FlowerPockAD/bin/release/FlowerAD-release.aar",
            "FlowerPockAD/bin/libs/csj_ad_sdk_230215.aar",
            "FlowerPockAD/bin/libs/gdt_ad_sdk_230210.aar",
            "FlowerPockAD/bin/libs/ks_ad_sdk_230116.aar",
            "FlowerPockAD/bin/libs/pocket_ad_sdk_3.2.8.aar",
            ])

    func _get_android_dependencies(platform: EditorExportPlatform, debug: bool) -> PackedStringArray:
        return PackedStringArray(["com.squareup.okhttp3:okhttp:4.9.2","com.google.code.gson:gson:2.8.8","androidx.legacy:legacy-support-core-ui:1.0.0","androidx.appcompat:appcompat:1.1.0","com.google.android.material:material:1.1.0","androidx.constraintlayout:constraintlayout:1.1.3"])

    func _get_android_dependencies_maven_repos(platform: EditorExportPlatform, debug: bool) -> PackedStringArray:
        return PackedStringArray([
            "https://jitpack.io",
        ])

    func _get_android_manifest_element_contents(platform: EditorExportPlatform, debug: bool) -> String:
        return """
        <uses-permission android:name="android.permission.INTERNET" />
        <uses-permission android:name="android.permission.WAKE_LOCK" />
        <uses-permission android:name="android.permission.GET_TASKS"/>
        <uses-permission android:name="android.permission.READ_PHONE_STATE" />
        <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
        <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
        <uses-permission android:name="android.permission.ACCESS_WIFI_STATE" />
        <uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
        <uses-permission android:name="android.permission.REQUEST_INSTALL_PACKAGES"/>
        <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
        """

    func _get_name():
        return _plugin_name
