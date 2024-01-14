# PockAdForGodot4.2

适用于 Godot4.2 的口袋工厂SDK接入。

当前适用版本：Godot4.2.1 Stable

## 用法

复制 addons 文件夹到你的项目根目录。

在 PockAd.gd 中修改你的 APP_ID。

启用插件，此时会自动增加一个名为 ```PockAD``` 的 autoload。

使用 ```PockAD.show_reward_video_ad(广告位ID:String)``` 来显示激励广告。

## 自己编译

你可能使用的 Godot 版本与本插件不符，这种情况下，你需要自己编译。

- clone 本仓库。

- sourcecode/FlowerAD 文件夹。

- 修改 ```FlowerAD/FlowerAD/build.gradle``` 找到第 46 行，修改为你的 Godot 版本。

- 在 FlowerAD 文件夹下执行 ```.\gradlew build``` （我使用 Andorid Atudio 无法 build。）


