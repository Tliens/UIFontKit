# UIFontKit
download and register custom fonts 下载并注册自定义字体

# 使用
### rigiester all cached fonts
### 注册所有本地已下载的字体

```
UIFontKitManager.shared.register()
```

### register font by urls
### just download once
### 注册网络上的字体,自动下载并缓存,只需下载一次,以后每次打开App后调用 register() 即可注册本地已下载字体

```
let url1:String = "https://github.com/quinn0809/QuinnDemo/raw/master/zzztest.ttf"
let url2:String = "https://github.com/quinn0809/QuinnDemo/raw/master/lccd.TTF"

let path = [url1,url2]

UIFontKitManager.shared.register(paths: paths) { (error, local, url) in

}
```
