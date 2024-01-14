package com.acidwall.pocketad

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.util.Log
import com.zh.pocket.PocketSdk

class InitActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_init)
        // 参数 1 为 channel：标识渠道（可随意填写），不要出现特殊字符即可；参数 2 为APPID(在开发者后台获取， 也可联系客服获取)

    }
}