//
//  UIFontKitManager.swift
//  UIFontKit
//
//  Created by Quinn on 2019/3/5.
//  Copyright © 2019 Quinn. All rights reserved.
//

import UIKit

class UIFontKitManager: NSObject {
    public static let shared = UIFontKitManager()
    private override init() {
        super.init()
    }
    
    // rigiester all cached fonts
    // 注册所有本地已下载的字体
    public func register(){
        do{
            try UFRegister.registerFont()
        }catch{
            debugPrint(#function,error)
        }
    }
    // register font by url eg: ["https://github.com/quinn0809/QuinnDemo/raw/master/zzztest.ttf"]
    // just download once
    // 注册网络上的字体,自动下载并缓存,只需下载一次,以后每次打开App后调用 register() 即可注册本地已下载字体
    public func register(paths:[String],callback:((_ error:Error?,_ localPath:String,_ urlPath:String)->Void)? = nil){
        for path in paths {
            UFDownloader.down(urlPath: path) { (error, localURL,urlPath) in
                if error == nil{
                    do{
                        try UFRegister.registerFontByURL(localURL)
                        callback?(error,localURL.path,urlPath)
                    }catch{
                        debugPrint(#function,error)
                        callback?(error,localURL.path,urlPath)
                    }
                }else{
                    callback?(error,localURL.path,urlPath)
                }
            }
        }
    }

}
